From: Trilok Soni <soni.trilok@gmail.com>
Subject: private ioctls in input driver
Date: Thu, 24 Sep 2009 17:21:09 +0530
Message-ID: <5d5443650909240451s17165707x6d3c7d3cf3228287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:20062 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZIXLvF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 07:51:05 -0400
Received: by qw-out-2122.google.com with SMTP id 5so569469qwd.37
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2009 04:51:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Dmitry,

Is there any way of creating private ioctls in the input driver? I see
that all the input framework handled
by the framework itself and there is no way to call private ioctls if
it doesn't match the standard ones.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
