From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] playing ff effect with code greater then FF_EFFECTS can cause buffer overflow
Date: Tue, 1 May 2007 22:53:47 -0400
Message-ID: <200705012253.47925.dtor@insightbb.com>
References: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <krata@matfyz.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Jan,

On Tuesday 01 May 2007 19:15, Jan Kratochvil wrote:
> From: Jan Kratochvil <honza@jikos.cz>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>,
>     linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
> Subject: [PATCH] playing ff effect with code greater then FF_EFFECTS can cause buffer overflow
> 
> Hi,
>   i found a bug in ff-memless.c so i fixed it. As you can see I am 
> doing check if effect_id is less then 0, but I am aware that it is useless 
> because effect_id is actually input_event.code which is __u16, but on the 
> other side as long as the effect_id is int I feel it is correct to check 
> whether it is > 0. 
>

Well spotted, thanks. However I think that the check should be moved up
the stack, into force feedback core. What do you think about the patch
below?

-- 
Dmitry


Input: force feedback - make sure effect is present before playing

Make sure that requested effect id is not out of range for the
device and that effect is present before requesting device to
play it.

Reported-by: Jan Kratochvil <honza@jikos.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/ff-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: work/drivers/input/ff-core.c
===================================================================
--- work.orig/drivers/input/ff-core.c
+++ work/drivers/input/ff-core.c
@@ -281,7 +281,8 @@ int input_ff_event(struct input_dev *dev
 		break;
 
 	default:
-		ff->playback(dev, code, value);
+		if (check_effect_access(ff, code, NULL) == 0)
+			ff->playback(dev, code, value);
 		break;
 	}
 
