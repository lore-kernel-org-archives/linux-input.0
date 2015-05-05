From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Tue, 05 May 2015 19:37:34 -0400
Message-ID: <5549543E.2030101@gmail.com>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com> <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com> <20150505211640.GA10272@amd> <20150505213606.GB15218@amd> <20150505214736.GA16332@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35427 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbbEEXho (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 19:37:44 -0400
Received: by qgej70 with SMTP id j70so89959843qge.2
        for <linux-input@vger.kernel.org>; Tue, 05 May 2015 16:37:43 -0700 (PDT)
In-Reply-To: <20150505214736.GA16332@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On 5/5/2015 17:47, Pavel Machek wrote:
> If it has just one motor, should it say so in the description? Not
> advertising both heavy and light motor.
>

The FF_RUMBLE flag exposes two motors by default and there doesn't seem 
to be a way to change it.

This is how the Wiimote with a single motor works (FF_RUMBLE and 
treating the strong/weak motors as one).  Would one of the other effects 
be more suitable?
