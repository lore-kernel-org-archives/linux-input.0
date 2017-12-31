From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Sun, 31 Dec 2017 12:37:56 +0800
Message-ID: <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
References: <20171230152213.GA2099@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48146 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdLaEiE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 23:38:04 -0500
In-Reply-To: <20171230152213.GA2099@marax.lan.yath.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>

Please refer to the Lenovo forum:

https://forums.lenovo.com/t5/forums/v3_1/forumtopicpage/board-id/Special_Interest_Linux/thread-id/9645/page/23

The patch you tried to revert solved many people's issue.
Also the people who used the trackpointdetect.exe to identify their ID
as (Elan (ID:03).

The elan driver can *not* work on their trackpoint, neither does ALPS.
They didn't match the ID tables, commands on ALPS or Elan driver.

The error log of Windows firmware update tools maybe wrong, so do NOT
based on it to guess what device it is.
