From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] drivers: input: joystick: Add PSX (Play Station 1/2)
 pad with SPI driver.
Date: Wed, 26 Apr 2017 10:52:24 +0200
Message-ID: <20170426105224.3bfe4b9a2d9f07f58b22ac10@ao2.it>
References: <20170425144422.9179-1-typesylph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ao2.it ([92.243.12.208]:33791 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2996866AbdDZJXB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 05:23:01 -0400
In-Reply-To: <20170425144422.9179-1-typesylph@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AZO <typesylph@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 25 Apr 2017 23:44:22 +0900
AZO <typesylph@gmail.com> wrote:

> PSX pads can be connected directry SPI bus.
                                  ^
                           "directly"

and add "to the" before SPI.

> 
> Signed-off-by: AZO <typesylph@gmail.com>
> ---

Hi,

I haven't looked at the code but I have some general comments.

When submitting another iteration of a patch it's common practice to
mention the version in the Subject (e.g. [PATCH v3] ...), you can use:

  git format-patch --subject-prefix='PATCH vX' ...

It is also useful to provide a changelog of the versions, so that
reviewers can see what the changes between the current patch and
the previous versions are. This changelog goes after the '---'
separator and before the diffstat, this way git will ignore it when the
patch is applied, it's meant for the review process and it doesn't need
to go in the commit message of the final version.

Further annotations can also go after the '---' separator.

For more details look at  Documentation/SubmittingPatches in the linux
kernel tree.

Also try to use a subject line consistent with the subsystem, by
looking at the history of the files in the same directory.

In this case it could be something like:

  Input: psxpad-spi - Add PSX (Play Station 1/2) pad SPI driver

Finally, script/checkpatch.pl suggests some minor issues, I tried with:

  ./scripts/checkpatch.pl --ignore LONG_LINE,LONG_LINE_COMMENT your.patch

You can ignore some of them, and motivate your decision in an
annotation.

Also try to comment when you do not agree with the reviewer or cannot
comply (for example about using an interrupt instead of polling).

It's fine if your English is not perfect yet, don't let that stop you :)

Ciao ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
