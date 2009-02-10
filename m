From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Tue, 10 Feb 2009 10:49:18 +0300
Message-ID: <78f5d6bf0902092349i46d84018g7dc0e742bf25f905@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <49871663.4060605@gmail.com>
	 <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
	 <498D7E81.4060007@gmail.com>
	 <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43527 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbZBJHtV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 02:49:21 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1235323fgg.17
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2009 23:49:18 -0800 (PST)
In-Reply-To: <78f5d6bf0902092146x2abaf45an79e4546e75a80356@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

Ok, here is what I got (I added few debug messages):
http://paste.org.ru/index.pl?n9joxr

Strange, that it can't find usage 0x25 in create new effect report, it
is actually there. I'll check this.

And something has to be done with missing direction field...
