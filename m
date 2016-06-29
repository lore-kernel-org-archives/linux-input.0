From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix oops when attaching an unknown Xbox One
 gamepad
Date: Wed, 29 Jun 2016 00:52:19 -0500
Message-ID: <57736213.3030803@gmail.com>
References: <5753B431.2040908@gmail.com> <20160623172726.GG32561@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34633 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcF2Fxd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 01:53:33 -0400
Received: by mail-pf0-f170.google.com with SMTP id h14so14416520pfe.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jun 2016 22:52:21 -0700 (PDT)
In-Reply-To: <20160623172726.GG32561@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 06/23/2016 12:27 PM, Dmitry Torokhov wrote:
> 
> But I think it would be even better if we still validated the number of
> endpoints afterwards so that a device with malicious descriptors would
> not crash the kernel. Any chance you could make such a patch?
> 
> Thanks!
> 

Yes, I will post it shortly.
