From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: [RFC] input: sysfs poll interval standards/preferences?
Date: Tue, 17 May 2011 16:30:21 -0400
Message-ID: <BANLkTinxhWT92Rce6VBLWBwxQOYC9vOKUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54020 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab1EQUaW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 16:30:22 -0400
Received: by vws1 with SMTP id 1so637039vws.19
        for <linux-input@vger.kernel.org>; Tue, 17 May 2011 13:30:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>

Hello all,
I am wondering whether any standards have been developed for using
sysfs to modify poll interval at runtime, particularly for sensors.  I
have an accelerometer driver (Kionix KXTJ9) that creates a node named
'delay' which accepts an integer (interpreted in milliseconds) and
uses it to change the poll interval controlling the input workqueue.
Is this acceptable, or should I be doing something differently?
Thank you,
Chris Hudson
