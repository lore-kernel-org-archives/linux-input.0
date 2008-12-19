From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] HID: avoid sparse warning in HID_COMPAT_LOAD_DRIVER
Date: Fri, 19 Dec 2008 09:31:00 +0100
Message-ID: <494B5BC4.100@gmail.com>
References: <4947a48f.08b6660a.34ca.ffffa1e8@mx.google.com>	 <20081216155822.GD12431@fluff.org.uk>	 <alpine.LNX.1.10.0812161659580.21089@jikos.suse.cz>	 <20081216194113.GF12431@fluff.org.uk> <154e089b0812161144x3c9579f5g8731b616fde6484c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:40848 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYLSIbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Dec 2008 03:31:09 -0500
In-Reply-To: <154e089b0812161144x3c9579f5g8731b616fde6484c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 12/16/2008 08:44 PM, Hannes Eder wrote:
> But, don't ask my why the void functions with empty function bodies
> are exported.

Because of autoload to create a dependency. Note that this is a temporary
solution to workaround the non-presence of hid bus in module-init-tools and will
be removed in next few releases.
