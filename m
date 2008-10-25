From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: appletouch driver broken
Date: Sat, 25 Oct 2008 23:13:01 +0200
Message-ID: <49038BDD.1050801@gmail.com>
References: <je7i7wmlbg.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:32099 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbYJYVNI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Oct 2008 17:13:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1391322fgg.17
        for <linux-input@vger.kernel.org>; Sat, 25 Oct 2008 14:13:06 -0700 (PDT)
In-Reply-To: <je7i7wmlbg.fsf@sykes.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: linux-input@vger.kernel.org

On 10/25/2008 11:11 PM, Andreas Schwab wrote:
> Commit c500c9714011edab021591340042787722db9cf0 ("HID: hid, make parsing
> event driven") broke the appletouch driver on iBook G4: the module is no
> longer autoloaded, and manual loading does not make it work either
> (atp_probe is never called).

Hi, please follow
http://bugzilla.kernel.org/show_bug.cgi?id=11825
