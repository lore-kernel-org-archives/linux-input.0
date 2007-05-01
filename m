From: Jan Kratochvil <krata@matfyz.cz>
Subject: [PATCH] playing ff effect with code greater then FF_EFFECTS can
 cause buffer overflow
Date: Wed, 2 May 2007 01:15:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

From: Jan Kratochvil <honza@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>,
    linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] playing ff effect with code greater then FF_EFFECTS can cause buffer overflow

Hi,
  i found a bug in ff-memless.c so i fixed it. As you can see I am 
doing check if effect_id is less then 0, but I am aware that it is useless 
because effect_id is actually input_event.code which is __u16, but on the 
other side as long as the effect_id is int I feel it is correct to check 
whether it is > 0. 

Jan.


From: Jan Kratochvil <honza@jikos.cz>

input: playing ff effect with code greater then FF_EFFECTS can cause buffer overflow

To reproduce this bug modify fftest to play effect with code > 15 and 
try to play this effect on device which is implemented using ff-memless.
ml_ff_playback() will try to access ml->states array over the boundary (array
is statically allocated to contain FF_EFFECTS fields). 

Signed-off-by: Jan Kratochvil <honza@jikos.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

---
 drivers/input/ff-memless.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index d226d93..bc546a6 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -396,7 +396,14 @@ static void ml_ff_set_gain(struct input_
 static int ml_ff_playback(struct input_dev *dev, int effect_id, int value)
 {
 	struct ml_device *ml = dev->ff->private;
-	struct ml_effect_state *state = &ml->states[effect_id];
+	struct ml_effect_state *state;
+	
+	if (effect_id < 0 || effect_id >= FF_MEMLESS_EFFECTS) {
+		printk(KERN_ERR "Effect id %d is out of range!\n", effect_id);
+		return -EINVAL;
+	}
+
+	state = &ml->states[effect_id];
 
 	spin_lock_bh(&ml->timer_lock);
 
-- 
1.4.3.4
