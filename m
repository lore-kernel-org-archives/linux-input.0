From: dupo.p@laposte.net
Subject: i2c_hid: probe of i2c-FTSC1000:00 failed with error -121
Date: Sun, 2 Apr 2017 12:49:46 +0200 (CEST)
Message-ID: <9730045.358567.1491130186606.JavaMail.zimbra@laposte.net>
References: <1888532196.351436.1491129872333.JavaMail.zimbra@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpoutz13.laposte.net ([194.117.213.172]:40072 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751165AbdDBKts (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Apr 2017 06:49:48 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout001 (Postfix) with ESMTP id D18794E5173D
        for <linux-input@vger.kernel.org>; Sun,  2 Apr 2017 12:49:46 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout001 (Postfix) with ESMTP id B447E4E51741
        for <linux-input@vger.kernel.org>; Sun,  2 Apr 2017 12:49:46 +0200 (CEST)
Received: from lpn-prd-mstr032.laposte (lpn-prd-mstr032.laposte [10.128.59.33])
        by lpn-prd-vrout001 (Postfix) with ESMTP id 9C6F44E5173D
        for <linux-input@vger.kernel.org>; Sun,  2 Apr 2017 12:49:46 +0200 (CEST)
In-Reply-To: <1888532196.351436.1491129872333.JavaMail.zimbra@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, 

I have the same touchscreen as you but in my case I've got an other error (on 4.11-rc4 kernel): 

i2c_hid i2c-FTSC1000:00: hid_descr_cmd failed 

I try to found a solution without result. 



