From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.28-rc2: USB/INPUT: slab error in cache_alloc_debugcheck_after():
 double free?
Date: Fri, 31 Oct 2008 20:45:51 +0100
Message-ID: <490B606F.3010100@gmail.com>
References: <200810310011.08618.deller@gmx.de> <20081031044553.50882e86@epia.jer-c2.orkz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:57652 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYJaTqY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 15:46:24 -0400
In-Reply-To: <20081031044553.50882e86@epia.jer-c2.orkz.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeroen Roovers <jer@gentoo.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org

On 10/31/2008 04:45 AM, Jeroen Roovers wrote:
> I am seeing the same USB problem but without the SLAB errors - [1] is
> the Gentoo bug report. The kernel boots fine with both USB keyboard and
> mouse detached.
> 
> 
> [17179609.760000] usb 1-2: configuration #1 chosen from 1 choice
> [17179609.860000] input: Kensington Kensington USB/PS2 Trackball as
> /class/inpu1
> [17179609.972000] Backtrace:

Could you boot with slub_debug kernel parameter?
