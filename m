From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: linux-next: USB mouse won't work after resume.
Date: Wed, 18 Feb 2009 10:51:06 +0100
Message-ID: <499BDA0A.5000904@gmail.com>
References: <Pine.LNX.4.44L0.0902171602510.18399-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:55812 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZBRJvL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 04:51:11 -0500
In-Reply-To: <Pine.LNX.4.44L0.0902171602510.18399-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Laurent Riffard <laurent.riffard@free.fr>, linux-input@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On 17.2.2009 22:05, Alan Stern wrote:
> On Tue, 17 Feb 2009, Oliver Neukum wrote:
>> Please try the attached patch.
>
> It seems likely that you are seeing the same problem as Laurent in your
> mmotm 2009-02-10-16-35 kernel.  You should try Oliver's patch,
> available here:
>
> 	http://marc.info/?l=linux-usb&m=123490330326229&w=2

Fixes the problem for me. Thanks.
