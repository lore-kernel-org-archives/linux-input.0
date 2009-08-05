From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: make matrix keymap size dynamic
Date: Wed, 05 Aug 2009 19:01:52 +0800
Message-ID: <4A7966A0.6020903@gmail.com>
References: <4A77FE31.3010209@gmail.com> <20090805082631.96C1A526EA5@mailhub.coreip.homeip.net>
Reply-To: eric.y.miao@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:38522 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbZHELB5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2009 07:01:57 -0400
Received: by ewy10 with SMTP id 10so3762ewy.37
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2009 04:01:56 -0700 (PDT)
In-Reply-To: <20090805082631.96C1A526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry Torokhov wrote:
> Hi Eric,
> 
> On Tue, Aug 04, 2009 at 05:24:01PM +0800, Eric Miao wrote:
>> The number of rows and columns should really belong to 'struct keymap_data',
>> and assumption on the shift and size of rows/columns removed.
>>
> 
> I aplayed with your patch for a while and moving rows and columns into
> struct keymap_data did not feel right; the changes to activate_cols and
> others where we have to access 2 different structures to get gpios and
> upper limit made the code awkward. In the end I decided the sizes should
> be kept where they were, together with the gpio arrays.
> 
> What do you think about the modified version of your patch below? The
> definitions seem to be working for other matrix drivers I have i my
> queue as well...
> 

Sure go. I'm quite happy with your approach.
