From: Ben Gamari <bgamari@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Tue, 14 Aug 2012 12:01:29 -0400
Message-ID: <87mx1xxy1y.fsf@gmail.com>
References: <20120814103553.GF23370@arianrhod.panaceas.james.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46955 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540Ab2HNQBc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 12:01:32 -0400
Received: by qaas11 with SMTP id s11so454254qaa.19
        for <linux-input@vger.kernel.org>; Tue, 14 Aug 2012 09:01:31 -0700 (PDT)
In-Reply-To: <20120814103553.GF23370@arianrhod.panaceas.james.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James <linux-input@madingley.org>, linux-input@vger.kernel.org

James <linux-input@madingley.org> writes:

> I just got a Dell E6230 with the same E7 report: 73 03 0a
> As noted above using the qemu serio logging doesn't work.
> The driver only enables multitouch if it sees the right
> name for the device in the DSDT.
>
> The following patch (against the seabios in qemu-0.14.1)
> enables the windows 7 driver (7.1211.101.114 from
> http://www.dell.com/support/drivers/us/en/04/DriverDetails/DriverFileFormats/Product/latitude-e6230?DriverId=CKNFN&FileId=2988050063&urlProductCode=False 
> ) to bind successfully and alows one to get data from the serio
> logging patch
>
> Are there any standard tools for reverse engineering the
> protocol - I saw mention of an alps-reg-dump but was
> unable to find it?
>
alps-reg-dump can be found here[1]. Depending upon how different the
protocol is it may or may not be useful, however.

Cheers,

- Ben


[1] http://kernel.ubuntu.com/git?p=sforshee/alps-reg-dump.git;a=summary
