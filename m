From: linux@johnea.net
Subject: Re: usbtouchscreen unreliable
Date: Fri, 02 Mar 2012 14:05:16 -0800
Message-ID: <4F51441C.7070806@johnea.net>
References: <4F5108DE.6060005@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:23465 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683Ab2CBWG3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Mar 2012 17:06:29 -0500
Received: from [192.168.100.166] (traveler.johnea.net [192.168.100.166])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id C597073F187D
	for <linux-input@vger.kernel.org>; Fri,  2 Mar 2012 14:06:28 -0800 (PST)
In-Reply-To: <4F5108DE.6060005@johnea.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 2012-03-02 09:52, linux@johnea.net wrote:
> 

> The touch screen works well initially, but after a day or so of operation, stops responding.

> From Xorg.log:
> [    26.418] (II) config/udev: Adding input device e2i Technology, Inc. USB Touchpanel (/dev/input/event5)

The touchscreen is currently in the failed state. 

If I:

# cat /dev/input/event5

Then touch the screen, there is no output.

johnea
