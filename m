From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH v2] [RFC] add video controls for SUR40 driver
Date: Tue,  6 Feb 2018 22:01:40 +0100
Message-ID: <1517950905-5015-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:59776 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753998AbeBFVB4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Feb 2018 16:01:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hverkuil@xs4all.nl, linux-media@vger.kernel.org
Cc: linux-input@vger.kernel.org, modin@yuri.at

As discussed previously, here's a second iteration of my patch to add
control functions for the SUR40 driver, now using the V4L2 control
framework.

