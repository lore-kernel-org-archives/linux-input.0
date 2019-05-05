From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: KASAN: use-after-free Read in add_uevent_var
Date: Sun, 5 May 2019 17:44:22 +0900
Message-ID: <75593427-4777-93ef-a141-5327a8afe75d@I-love.SAKURA.ne.jp>
References: <000000000000559435058813dc8d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000559435058813dc8d@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+6da9575ba2db4da91831@syzkaller.appspotmail.com>, syzkaller-bugs@googlegroups.com
Cc: airlied@linux.ie, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, hpa@zytor.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, patrik.r.jakobsson@gmail.com, rydberg@bitmath.org, tglx@linutronix.de, wsa@the-dreams.de, x86@kernel.org
List-Id: linux-input@vger.kernel.org

This seems to be triggered by "pkg/report: skip printk and other printing functions " on syzbot side.
The fix should be "kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice." in linux-next.git.

#syz dup: KASAN: use-after-free Read in string
