From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Method to power off HID device from driver?
Date: Thu, 19 Jan 2017 14:37:40 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701191436220.25515@cbobk.fhfr.pm>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com> <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com> <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com> <1481168348.2286.11.camel@hadess.net>
 <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753107AbdASNho (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 08:37:44 -0500
In-Reply-To: <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: Bastien Nocera <hadess@hadess.net>, Cameron Gutman <aicommander@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, 9 Jan 2017, Roderick Colenbrander wrote:

> From the sounds of it various others are interested in the ability to
> trigger a device disconnect as well. Since I don't think any of us
> have a good enough understanding of the HID / input frameworks, I'm
> adding Benjamin and Jiri. Maybe they have some good ideas on how to
> tackle this.

Well, this really depends on the low-level (transport, as we call it in 
HID) driver.

USB, for example, has it's own runtime power management, and the devices 
auto-suspend and auto-resume themselves almost automatically without too 
many specific generic code requirements.

What is the hardware transport we're talking about here?

-- 
Jiri Kosina
SUSE Labs

