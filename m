From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 19:13:05 +0100
Message-ID: <4D026DB1.8070100@euromail.se>
References: <1291929732-5989-1-git-send-email-rydberg@euromail.se> <AANLkTi=mqMY_VG=0RdN5O0fDh6wpTRb5Z59L6440hvX6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=mqMY_VG=0RdN5O0fDh6wpTRb5Z59L6440hvX6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>

> Can we make MT_TOOL_ENVELOPE cover a bit more cases by:
> 
> 1. Removing ", and is only used for legacy hardware";
> 2. Adding "Or the number of contacts inside the bounding rectangle is
> reported if hardware provides the number but not the real contact
> positions" to the end of the paragraph.


You might disagree, but "old" is still somewhat apt in this situation. How would
you suggest we report the number of fingers?

Henrik
