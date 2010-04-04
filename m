From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: Bug: Short reset of ps/2 mouse causes Synaptics touchpad
	misdetection
Date: Sun, 04 Apr 2010 19:35:17 +0200
Message-ID: <1270402517.3614.7.camel@lovely>
References: <s2ydfb03c971004040858p6872d1f4p3fc0f8dac1fbd2e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:23766 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab0DDRaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Apr 2010 13:30:25 -0400
Received: by fg-out-1718.google.com with SMTP id d23so135197fga.1
        for <linux-input@vger.kernel.org>; Sun, 04 Apr 2010 10:30:23 -0700 (PDT)
In-Reply-To: <s2ydfb03c971004040858p6872d1f4p3fc0f8dac1fbd2e6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Lam <lambchop468@gmail.com>
Cc: linux-input@vger.kernel.org

> 
> Bug: Short reset of ps/2 mouse causes Synaptics touchpad misdetection
> 

commit 4a299bf591bc5bef3bde8316e603b9eaec5a7696
commit 9230ccb1071d2d7e4ecb6314e67203b9f7f08140
commit 3e6e15a862a0bc20128497bbdc54254cdec21835

does it work with all these applied?




