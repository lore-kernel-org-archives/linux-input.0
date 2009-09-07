From: Trilok Soni <soni.trilok@gmail.com>
Subject: Handling stuck keys
Date: Mon, 7 Sep 2009 16:32:06 +0530
Message-ID: <5d5443650909070402s33ec5385h49df18821507ea5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:30889 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZIGLJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 07:09:03 -0400
Received: by qw-out-2122.google.com with SMTP id 8so652636qwh.37
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2009 04:09:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

What is the preferred way to handle stuck key notification through driver?

I feel the following scenario would work assuming that controller is
able to detect the stuck key and gives us an interrupt.

- Once the interrupt is raised, we go and find out which key is stuck
through regular key scanning logic.
- We find the key which is the vicitim and forcefully send "release"
key event through input_report_key.

I saw other drivers in the input subsystem where people are handling
keyboard quirks with forceful release, so I hope the same should with
stuck keys too.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
