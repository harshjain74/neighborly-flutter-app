import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:neighborly_flutter_app/core/error/failures.dart';
import 'package:neighborly_flutter_app/core/network/network_info.dart';

import '../data_sources/upload_remote_data_source/upload_remote_data_source.dart';
import '../../domain/repositories/upload_repositories.dart';

class UploadRepositoriesImpl implements UploadRepositories {
  final UploadRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UploadRepositoriesImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> uploadPost({
    required String title,
    String? content,
    required String type,
    File? multimedia,
    required String city,
    List<dynamic>? options,
    required bool allowMultipleVotes,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.uploadPost(
          title: title,
          content: content,
          type: type,
          multimedia: multimedia,
          allowMultipleVotes: allowMultipleVotes,
          city: city,
          options: options,
        );
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: '$e'));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile({required File file}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.uploadFile(file: file);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: '$e'));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
