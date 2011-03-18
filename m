From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/2] input: Pegatron Lucid accelerometer
Date: Fri, 18 Mar 2011 16:39:38 +0100
Message-ID: <20110318163938.3cb91027@destiny.ordissimo>
References: <1295287011-12849-1-git-send-email-andy.ross@windriver.com>
	<1295287011-12849-2-git-send-email-andy.ross@windriver.com>
	<4D3529A1.1030804@ti.com>
	<4D35CC1B.3020808@windriver.com>
	<20110131213057.GA9259@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab1CRPjs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2011 11:39:48 -0400
In-Reply-To: <20110131213057.GA9259@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andy Ross <andy.ross@windriver.com>, Shubhrajyoti <shubhrajyoti@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Mon, 31 Jan 2011 21:30:57 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote :

> On Tue, Jan 18, 2011 at 09:21:31AM -0800, Andy Ross wrote:
> 
> > It's just an ACPI method interface, so no dedicated IRQ certainly.
> > The firmware does issue ACPI events on coarse orientation changes
> > (i.e. which edge is up) that we're catching with acpid, so there's no
> > reason this needs to poll all the time in typical usage.
> 
> It'd be good to provide those via some more generally-usable mechanism 
> than raw ACPI events.
> 
Something like that ?


From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] asus-laptop: Send input event when orientation changes on Pegatron Lucid

Pegatron Lucid tablet sends an ACPI event on coarse orientation changes.
Translate this into KEY_DIRECTION input event.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/asus-laptop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 75c84f8..d32395c 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -312,6 +312,8 @@ static const struct key_entry asus_keymap[] = {
 	{KE_KEY, 0xc4, { KEY_KBDILLUMUP } },
 	{KE_KEY, 0xc5, { KEY_KBDILLUMDOWN } },
 	{KE_KEY, 0xb5, { KEY_CALC } },
+	/* Pegatron Lucid tablet specific */
+	{KE_KEY, 0xEA, { KEY_DIRECTION } }, /* Orientation changed */
 	{KE_END, 0},
 };
 
-- 
1.7.3.2

