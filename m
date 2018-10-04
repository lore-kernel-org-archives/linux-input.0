From: Eric Dumazet <edumazet@google.com>
Subject: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
Date: Thu,  4 Oct 2018 08:47:49 -0700
Message-ID: <20181004154749.111595-1-edumazet@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

syzbot was able to trigger rcu stalls by calling write()
with large number of bytes.

Add a cond_resched() in the loop to avoid this.

Link: https://lkml.org/lkml/2018/8/23/1106
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/mousedev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
 		mousedev_generate_response(client, c);
 
 		spin_unlock_irq(&client->packet_lock);
+		cond_resched();
 	}
 
 	kill_fasync(&client->fasync, SIGIO, POLL_IN);
-- 
2.19.0.605.g01d371f741-goog
