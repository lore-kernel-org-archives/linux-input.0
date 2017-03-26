From: dupo.p@laposte.net
Subject: i2c_hid i2c-FTSC1000:00: hid_descr_cmd failed error message.
Date: Sun, 26 Mar 2017 13:11:05 +0200 (CEST)
Message-ID: <152643124.602057.1490526665750.JavaMail.zimbra@laposte.net>
References: <961903324.597755.1490526501175.JavaMail.zimbra@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpoutz10.laposte.net ([194.117.213.175]:45488 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751300AbdCZLSG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Mar 2017 07:18:06 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 01459593A6A
        for <linux-input@vger.kernel.org>; Sun, 26 Mar 2017 13:11:06 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id D9AA7593A62
        for <linux-input@vger.kernel.org>; Sun, 26 Mar 2017 13:11:05 +0200 (CEST)
Received: from lpn-prd-mstr032.laposte (lpn-prd-mstr032.laposte [10.128.59.33])
        by lpn-prd-vrout004 (Postfix) with ESMTP id C3BB5593A6A
        for <linux-input@vger.kernel.org>; Sun, 26 Mar 2017 13:11:05 +0200 (CEST)
In-Reply-To: <961903324.597755.1490526501175.JavaMail.zimbra@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm looking for informations about an error message that I see via my dmesg command. I want to know what it means. Perhaps you can tell me what's wrong.

Here is the dmesg error message I've got :

 i2c_hid i2c-FTSC1000:00: hid_descr_cmd failed

FTSC1000:00 matches to my touchscreen.

I'm looking for informations on the net but I didn't find anything about it.
If there is a solution or a patch to solve this problem, it would be nice.
I've got this error message with 4.10.x, 4.11-rc1 and 4.11-rc2 kernel.

Regards.

