From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] HID: logitech: read all 32 bits of report type
 bitfield
Date: Fri, 11 May 2012 02:43:02 -0500
Message-ID: <20120511074302.GC5733@burratino>
References: <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120506031428.GA20044@hugoo.com.ar>
 <20120506055508.GA21209@burratino>
 <4FA6162F.1020408@osvaldobarrera.com.ar>
 <20120506062309.GB26002@burratino>
 <20120511050639.GA13777@hugoo.com.ar>
 <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com>
 <20120511072231.GA5733@burratino>
 <CAE7qMrp6VvdWNrMhdcisig8pKdzuNQQDmQLrF4x6bnfF880tCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41204 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab2EKHnH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 03:43:07 -0400
Received: by gglu4 with SMTP id u4so1531501ggl.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 00:43:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE7qMrp6VvdWNrMhdcisig8pKdzuNQQDmQLrF4x6bnfF880tCA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org, Jiri Kosina <jkosina@suse.cz>

Nestor Lopez Casado wrote:

> The patch looks perfect to me. Wonderful 'get_unaligned_le32' that I
> looked for and did not find when trying to fix the original code.
>
> On my side no issues for Jiri to apply it.

Nice to hear.  Thanks again for all your help.

Ciao,
Jonathan
