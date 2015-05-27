From: James C Boyd <jcboyd.dev@gmail.com>
Subject: [PATCH 0/3] HID: hid-input: Simplify expression and suppress gcc warning
Date: Wed, 27 May 2015 17:09:05 -0500
Message-ID: <cover.1432761541.git.jcboyd.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35988 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbE0WJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 18:09:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch set simplifies and formats an expression
as well as suppress a gcc warning.

James C Boyd (3):
  HID: hid-input: Add parenthesis to suppress gcc warning
  HID: hid-input: Simplified conditional expression
  HID: hid-input: Fix coding style issue

 drivers/hid/hid-input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
--
