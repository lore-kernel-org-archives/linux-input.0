From: simon@mungewell.org
Subject: Re: [PATCH v2 09/24] input: Port hid-dr to ff-memless-next
Date: Wed, 23 Apr 2014 11:47:05 -0400
Message-ID: <0792885b3347c5935a0af7a7a3f3bc70.squirrel@mungewell.org>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
    <1398175209-9565-10-git-send-email-madcatxster@devoid-pointer.net>
    <1398260463.32091.5.camel@linux-fkkt.site>
    <5sjip0.n4hp0o.2szhuh-qmf@smtp.devoid-pointer.net>
    <20140423154201.GA10531@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:53810 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbaDWPrJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 11:47:09 -0400
In-Reply-To: <20140423154201.GA10531@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: madcatxster@devoid-pointer.net, oneukum@suse.de, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org, linux-input@vger.kernel.org

> On Wed, Apr 23, 2014 at 03:14:44PM +0000, madcatxster@devoid-pointer.net
> wrote:
>> This is another case where even the old code was flawed, right? Should
>> I try to stuff the fixes into these patches or would a few extra
>> patches addressing these problems be an easier to review solution? I
>> can append such patches to the MLNX patchset.
>
> Changes addressing pre-existing problem should go into separate patches
> (preferably applicable first).
>

As a by-stander who would like to see MLNX move forward, should it be
heldback by pre-existing problems in drivers that the MLNX dev(s) don't
have hardware to test against...?

Simon.

