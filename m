From: Melchior FRANZ <melchior.franz@gmail.com>
Subject: Re: [BUG?] hid-core.c: hid->name = dev->manufacturer + dev->product ... why not + dev->serial?
Date: Tue, 9 Mar 2010 19:58:27 +0100
Message-ID: <201003091958.27832@rk-nord.at>
References: <201003071655.06644@rk-nord.at> <20100309184127.GE19814@core.coreip.homeip.net> <201003091952.40853@rk-nord.at>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from WARSL404PIP2.highway.telekom.at ([195.3.96.113]:37420 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755639Ab0CIS63 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 13:58:29 -0500
Received: from 93-82-15-81.adsl.highway.telekom.at (HELO server.lan) ([93.82.15.81])
          (envelope-sender <melchior.franz@gmail.com>)
          by smarthub98.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 9 Mar 2010 18:58:26 -0000
Received: from server.localnet (localhost [127.0.0.1])
	by server.lan (Postfix) with ESMTP id 17DA4BE1A2
	for <linux-input@vger.kernel.org>; Tue,  9 Mar 2010 19:58:28 +0100 (CET)
In-Reply-To: <201003091952.40853@rk-nord.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

* Melchior FRANZ -- Tuesday 09 March 2010:
> Hmm, then I wonder why the joystick names are different on Windows and
> Linux already.  :-}

Oh, wait. That was an inaccurate statement. I have no idea how that
application retrieved the joystick name. Maybe it has a choice and
just didn't bother to ask for the manufacturer.

m
