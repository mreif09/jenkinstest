#include "gtest/gtest.h"

#include "testfile.hpp"

TEST(testfile, sum) {
  EXPECT_EQ(sum(2, 3), 5);
}

TEST(testfile, diff) {
  int a;
  EXPECT_EQ(diff(3, 2), 1);
}