From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Mon, 14 Dec 2009 15:48:43 -0700
Message-ID: <db910869762a655c288c762e82e83d3e.squirrel@intranet.cs.nmsu.edu>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
    <20091214220220.GB2052@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758701AbZLNWtv@vger.kernel.org>
In-Reply-To: <20091214220220.GB2052@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "krzysztof.h1@wp.pl" <krzysztof.h1@wp.pl>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "oliver@neukum.org" <oliver@neukum.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hello,

Felipe Balbi wrote:
> On Mon, Dec 14, 2009 at 10:22:32PM +0100, ext Rick L. Vinyard Jr. wrote:
>>
>>Signed-off-by: Rick L. Vinyard, Jr <rvinyard@cs.nmsu.edu>
>
> there are plenty of style mistakes in this patch. the body message
> description which you put below should be above the signed-off-by line,

Fixed in the new patch labelled 0.0.2

> multi-lined comments are of the form:
>
> /*
>   * multi lined comment
>   * goes here
>   */
>

Fixed

> remove the commented code like /* hid_debug = 0 */
>

Removed

> and some others.. please run your patch through scripts/checkpatch.pl
> --strict and fix the errors and warnings reported.
>

I ran it without the --strict option before. That's probably why I didn't
catch it. It's clean now with --strict.

>>+static int __init g13_init(void)
>>+{
>>+       pr_debug("g13 HID driver loaded");
>
> don't pr_debug() here.
>

Removed

>>+       return hid_register_driver(&g13_driver);
>>+}
>>+
>>+static void __exit g13_exit(void)
>>+{
>>+       pr_debug("g13 HID driver unloaded");
>
> nor here.
>
>>+       hid_unregister_driver(&g13_driver);
>>+}

Removed

Thanks for the input. Everything above is taken into account in v0.0.2 of
the patch.

---

Rick
