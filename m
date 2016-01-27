From: "Piotr Sawuk" <a9702387@unet.univie.ac.at>
Subject: Re: [Patch] hid: enhance hid-saitek for use with R.A.T.5 and
 similar
Date: Thu, 28 Jan 2016 00:16:55 +0100
Message-ID: <9617e7c332cd0041c92ca9c95dc12fea.squirrel@webmail.univie.ac.at>
References: <5690FEB0.4040809@unet.univie.ac.at>
    <alpine.LNX.2.00.1601261527260.21446@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from grace.univie.ac.at ([131.130.3.115]:50235 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbcA0XQ7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:16:59 -0500
In-Reply-To: <alpine.LNX.2.00.1601261527260.21446@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Di, 26.01.2016, 15:29, Jiri Kosina wrote:
> On Sat, 9 Jan 2016, Piotr Sawuk wrote:
>

>> Signed-off-by: Piotr Sawuk <piotr5@users.sf.net>
>
> The patch has been damaged by your mail client, and as such can't be
> applied. Could you please fix that up and resend?

thanks, I fixed that by an addon to thunderbird.
>

>
> Could you please keep the list sorted (at least by parts)?

done.
>

>> +	hdev = container_of(dev, struct hid_device, dev);
>
> You can use to_hid_device() here.

sorry, didn't notice that recent addition.
my new patch wont work against older kernel versions though...

P

