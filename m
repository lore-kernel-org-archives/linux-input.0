From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Mon, 7 Dec 2009 12:55:53 +0000
Message-ID: <20091207125553.GA31448@srcf.ucam.org>
References: <1259826317-18809-31-git-send-email-corentincj@iksaif.net> <1259826317-18809-32-git-send-email-corentincj@iksaif.net> <1259826317-18809-33-git-send-email-corentincj@iksaif.net> <20091203075404.GK9121@core.coreip.homeip.net> <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com> <20091206065829.GI5340@wrars-comp.wrarsdomain> <20091206071751.GD14651@core.coreip.homeip.net> <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com> <20091206145415.GA16414@srcf.ucam.org> <20091207114749.GD20076@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091207114749.GD20076@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Corentin Chary <corentin.chary@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrey Rahmatullin <wrar@altlinux.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 07, 2009 at 09:47:49AM -0200, Henrique de Moraes Holschuh wrote:

> What I do know, is that I will miss a keycode that rfkills just my WLAN... I
> use that for power management, it is nice to have a key that is for WLAN
> only, and another that is for bluetooth-only...

KEY_WLAN will still be there, and you can still remap. But the default 
behaviour should be for thinkpad-acpi (for instance) to generate 
KEY_RFKILL, since Fn+F5 isn't supposed to be wlan only.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
