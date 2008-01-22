From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: [PATCH] input: constify function pointer tables
Date: Tue, 22 Jan 2008 20:55:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801222054560.5722@fbirervta.pbzchgretzou.qr>
References: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:37119 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbYAVTzK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2008 14:55:10 -0500
In-Reply-To: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
---
 drivers/input/input.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a0be978..570cbcd 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -755,7 +755,7 @@ static int input_devices_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static struct seq_operations input_devices_seq_ops = {
+static const struct seq_operations input_devices_seq_ops = {
 	.start	= input_devices_seq_start,
 	.next	= input_devices_seq_next,
 	.stop	= input_devices_seq_stop,
@@ -808,7 +808,7 @@ static int input_handlers_seq_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-static struct seq_operations input_handlers_seq_ops = {
+static const struct seq_operations input_handlers_seq_ops = {
 	.start	= input_handlers_seq_start,
 	.next	= input_handlers_seq_next,
 	.stop	= input_handlers_seq_stop,
-- 
1.5.3.4

