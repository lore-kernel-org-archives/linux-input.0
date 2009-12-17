From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] MAINTAINERS: add maintainer for msi-wmi driver
Date: Thu, 17 Dec 2009 11:28:49 +0100
Message-ID: <20091217112849.561aee8e@destiny.ordissimo>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
	<1260451099-25620-2-git-send-email-anisse@astier.eu>
	<9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>
	<20091214105533.6634312b@destiny.ordissimo>
	<alpine.LFD.2.00.0912161238290.6089@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0912161238290.6089@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi Len,

I'm willing to take maintainership for this driver, as long as I have access
to hardware (i.e my current job).

Regards,

Anisse

 MAINTAINERS |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a32c3e..b2d551c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3635,6 +3635,11 @@ W:	http://0pointer.de/lennart/tchibo.html
 S:	Maintained
 F:	drivers/platform/x86/msi-laptop.c
 
+MSI WMI SUPPORT
+M:	Anisse Astier <anisse@astier.eu>
+S:	Supported
+F:	drivers/platform/x86/msi-wmi.c
+
 MULTIFUNCTION DEVICES (MFD)
 M:	Samuel Ortiz <sameo@linux.intel.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6.git
-- 
1.6.5.3

