From: Benson Leung <bleung@chromium.org>
Subject: [PATCH v2 0/1] Input: add driver for Cypress APA I2C Trackpad
Date: Wed,  5 Dec 2012 16:48:18 -0800
Message-ID: <1354754899-26701-1-git-send-email-bleung@chromium.org>
References: <1341959357-14691-1-git-send-email-bleung@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44207 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2LFAsc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 19:48:32 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4069444pbc.19
        for <linux-input@vger.kernel.org>; Wed, 05 Dec 2012 16:48:32 -0800 (PST)
In-Reply-To: <1341959357-14691-1-git-send-email-bleung@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bleung@chromium.org, djkurtz@chromium.org, olofj@chromium.org, dudl@cypress.com

Thanks for the patience on this driver. I have stripped out firmware update,
the sysfs properties around firmware version, hardware version, update_fw,
and power state.

I have incorporated rydberg's suggestions for cleanup.

