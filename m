From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH 1/6] Input: add support for large scancodes
Date: Fri, 29 Oct 2010 23:34:15 +0100
Message-ID: <201010292334.20732.james@albanarts.com>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv> <20100908074144.32365.27232.stgit@hammer.corenet.prv> <201010292236.07437.james@albanarts.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <201010292236.07437.james@albanarts.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, David Hardeman <david@hardeman.nu>, Jiri Kosina <jkosina@suse.cz>, Ville Syrjala <syrjala@sci.fi>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-input@vger.kernel.org

On Friday 29 October 2010 22:36:06 James Hogan wrote:
> I thought I better point out that this breaks make htmldocs (see below)
> because of the '<' characters "in" a kernel doc'd struct. This is with
> 12ba8d1e9262ce81a695795410bd9ee5c9407ba1 from Linus' tree (>2.6.36). Moving
> the #define below the struct works around the problem, but I guess the real
> issue is in the kerneldoc code.

appologies for the noise.
I see Randy had already beaten me to a fix.

Cheers
James
