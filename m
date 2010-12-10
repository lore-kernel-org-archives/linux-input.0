From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Interface and MT_TOOL documentation updates
Date: Thu, 9 Dec 2010 23:43:51 -0800
Message-ID: <20101210074351.GC21009@core.coreip.homeip.net>
References: <1291929732-5989-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291929732-5989-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 09, 2010 at 10:22:12PM +0100, Henrik Rydberg wrote:
> The recent input-mt interface changes together with
> recent discussions about pen and touch and support
> for legacy multitouch pads suggest that the documentation
> on MT tool types be expanded. This patch adds references
> to the new interface, and adds a section for MT_TOOL types,
> in particular documenting the use of MT_TOOL_ENVELOPE.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>


The explanation of the new types makes sense to me... Do you think we
could add some comments directly to input.h?


> @@ -247,21 +249,34 @@ ABS_MT_TOOL_TYPE
>  The type of approaching tool. A lot of kernel drivers cannot distinguish
>  between different tool types, such as a finger or a pen. In such cases, the
>  event should be omitted. The protocol currently supports MT_TOOL_FINGER and

s/and/,/

> -MT_TOOL_PEN and MT_TOOL_ENVELOPE [2].
> +MT_TOOL_PEN and MT_TOOL_ENVELOPE [2]. For type B devices, this event is
> +handled by input core, via the input_mt interface.
> +

Thanks.

-- 
Dmitry
