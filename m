From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCHES] hid: Add support for more Huion tablets
Date: Wed, 23 Jul 2014 16:39:43 +0300
Message-ID: <53CFBB1F.2000905@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:47801 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaGWNjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 09:39:47 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so1200809wgg.19
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 06:39:46 -0700 (PDT)
In-Reply-To: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 07/23/2014 03:42 PM, Nikolai Kondrashov wrote:
> The Huion tablets seem to all use a single product ID and the iProduct strings
> are inconsistent. So there isn't much to identify the models with so far,
> although the magic string descriptor containing tablet parameters has some
> internal model name which might be used to identify them in the future.

A minor correction for the record: the internal model is contained in a string
descriptor separate from the one carrying the device parameters.

See https://github.com/DIGImend/huion-tools for details.

Nick
