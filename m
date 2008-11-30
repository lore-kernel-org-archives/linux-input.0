From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fujitsu Amilo PA 1510 key-release events quirk
Date: Sat, 29 Nov 2008 23:42:30 -0800
Message-ID: <20081129234230.86730f14.akpm@linux-foundation.org>
References: <4931BB48.9010706@impulze.org>
	<20081129233826.be959cae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50205 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273AbYK3Hmf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Nov 2008 02:42:35 -0500
In-Reply-To: <20081129233826.be959cae.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mierswa <impulze@impulze.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 29 Nov 2008 23:38:26 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Just write a C function:
> 
> void atkbd_gen_release_event(unsigned int *keys, unsigned nr_keys)

                               ^ const

> {
> 	...
> }
> 
> 
