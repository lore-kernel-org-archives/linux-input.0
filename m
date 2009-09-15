From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: MX5000 support in hid-logitech
Date: Tue, 15 Sep 2009 18:04:43 +0200
Message-ID: <71cd59b00909150904h7fdb678sc5f005debd5e4ff2@mail.gmail.com>
References: <200909151240.14486.corentin.chary@gmail.com>
	 <1253012633.23937.8321.camel@localhost.localdomain>
	 <200909151444.29108.corentin.chary@gmail.com>
	 <200909151552.11811.corentin.chary@gmail.com>
	 <alpine.LNX.2.00.0909151632280.17028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33545 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZIOQEl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 12:04:41 -0400
Received: by bwz19 with SMTP id 19so2902938bwz.37
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2009 09:04:43 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0909151632280.17028@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

On Tue, Sep 15, 2009 at 4:34 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 15 Sep 2009, Corentin Chary wrote:
>
>> In fact .. my first patch works with showkey, not with xev ...
>> I'll try to figure out why.
>
> That's unfortunate limitation of X server/protocol -- keycodes higher than
> 255 (more than 8 bit) do not reach the usual desktop applications (e.g.
> xev). See http://bugs.freedesktop.org/show_bug.cgi?id=11227 for more
> information.

Thanks. I'll post a patch working with showkey then ...

-- 
Corentin Chary
http://xf.iksaif.net
