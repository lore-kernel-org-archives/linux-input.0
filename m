From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Sun, 6 Dec 2009 14:54:15 +0000
Message-ID: <20091206145415.GA16414@srcf.ucam.org>
References: <1259826317-18809-29-git-send-email-corentincj@iksaif.net> <1259826317-18809-30-git-send-email-corentincj@iksaif.net> <1259826317-18809-31-git-send-email-corentincj@iksaif.net> <1259826317-18809-32-git-send-email-corentincj@iksaif.net> <1259826317-18809-33-git-send-email-corentincj@iksaif.net> <20091203075404.GK9121@core.coreip.homeip.net> <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com> <20091206065829.GI5340@wrars-comp.wrarsdomain> <20091206071751.GD14651@core.coreip.homeip.net> <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrey Rahmatullin <wrar@altlinux.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Dec 06, 2009 at 09:21:12AM +0100, Corentin Chary wrote:

> Old xandros builds use the acpi event.
> New builds have switched to eeepc-laptop (based on my 2.6.30
> backport), so they may use an input event (KEY_WLAN).

Yeah. We should probably change that to KEY_RFKILL once that lands.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
