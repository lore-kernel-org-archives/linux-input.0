From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Tue, 15 Dec 2009 00:02:20 +0200
Message-ID: <20091214220220.GB2052@nokia.com>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758582AbZLNWDY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: "ext Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "krzysztof.h1@wp.pl" <krzysztof.h1@wp.pl>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "oliver@neukum.org" <oliver@neukum.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, Dec 14, 2009 at 10:22:32PM +0100, ext Rick L. Vinyard Jr. wrote:
>
>Signed-off-by: Rick L. Vinyard, Jr <rvinyard@cs.nmsu.edu>

there are plenty of style mistakes in this patch. the body message 
description which you put below should be above the signed-off-by line,
multi-lined comments are of the form:

/*
  * multi lined comment
  * goes here
  */

remove the commented code like /* hid_debug = 0 */

and some others.. please run your patch through scripts/checkpatch.pl 
--strict and fix the errors and warnings reported.

please take a look at Documentation/SubmittingPatches and 
Documentation/CodingStyle for further reference.

When sending the patch, you could also use git send-email to avoid the 
problem you had with 'mail'.

>+static int __init g13_init(void)
>+{
>+       pr_debug("g13 HID driver loaded");

don't pr_debug() here.

>+       return hid_register_driver(&g13_driver);
>+}
>+
>+static void __exit g13_exit(void)
>+{
>+       pr_debug("g13 HID driver unloaded");

nor here.

>+       hid_unregister_driver(&g13_driver);
>+}

-- 
balbi
