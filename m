From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: asus: Add product-id for the T100TAF and T100HA
 keyboard docks
Date: Fri, 1 Dec 2017 09:55:00 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1712010954120.11505@cbobk.fhfr.pm>
References: <20171126154010.954-1-hdegoede@redhat.com> <20171127083531.GD30708@mail.corp.redhat.com> <47b2d7b2-c24b-2705-5be6-9c100d0ed4c0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdLAIzC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 1 Dec 2017 03:55:02 -0500
In-Reply-To: <47b2d7b2-c24b-2705-5be6-9c100d0ed4c0@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, 27 Nov 2017, Hans de Goede wrote:

> I'm afraid it is probably the first reason and not the second reason,
> when I was working on Linux webcam support one of the issues was that in
> many Asus laptops the webcam module is mounted upside down and thus sends
> an upside-down picture. I asked via via if Asus internally had a list
> of which webcams are upside down, the answer was: no. Asus simply maintains
> a hacked-together driver-repository per model laptop, in which they
> put hacks until the driver works for that model. 

Man, the world is sick :)

I am unhappily (not because of you, but because of ASUS) applying to 
for-4.15/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

