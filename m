From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Wed, 30 May 2007 15:42:08 +0100
Message-ID: <20070530144208.GA30351@srcf.ucam.org>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com> <20070530140450.GA29514@srcf.ucam.org> <d120d5000705300718o61f01a78r67e19449f8537c55@mail.gmail.com> <20070530142516.GA30009@srcf.ucam.org> <d120d5000705300731p324fb5d4j6f800044b27b4388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000705300731p324fb5d4j6f800044b27b4388@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, May 30, 2007 at 10:31:35AM -0400, Dmitry Torokhov wrote:

> Not all world is X :)  Actually few of "FN" keys, like KEY_WLAN,
> KEY_SLEEP, etc should be handled not [only] by X but by other layers.

I agree - the ones that have a defined function should certainly be set 
to sensible defaults, but I think the sensible default for a key without 
a defined function is "Key of undefined function" (like KEY_PROG*), not 
"Key which doesn't generate a keycode" :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
