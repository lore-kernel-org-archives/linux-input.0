From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Document the bcm5974 driver
Date: Tue, 28 Apr 2009 14:56:04 +0200
Message-ID: <49F6FCE4.9080409@euromail.se>
References: <1240916817-18995-1-git-send-email-rydberg@euromail.se> <49F6ED54.7040200@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46738 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753891AbZD1M5N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2009 08:57:13 -0400
In-Reply-To: <49F6ED54.7040200@wincor-nixdorf.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> 
> What about skipping rmmod and modprobe by doing
> 	echo -n 9 > /sys/module/bcm5974/parameters/debug
> and
> 	echo -n 0 > /sys/module/bcm5974/parameters/debug
> ?

Much neater, I'll send a revised patch right away. Thanks!

Henrik

