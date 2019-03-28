From: syzbot <syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com>
Subject: Re: INFO: task hung in evdev_release
Date: Wed, 27 Mar 2019 18:24:01 -0700
Message-ID: <000000000000bf3ccd05851d68a7@google.com>
References: <000000000000f1be430578524a20@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000f1be430578524a20@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, jbrunet@baylibre.com, lgirdwood@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

syzbot has bisected this bug to:

commit e32d99af6830c9a8f37b4f2637ef0cdc60fa79fb
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Tue Jul 17 15:42:50 2018 +0000

     ASoC: meson: add axg fifos DT binding documentation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fba69b200000
start commit:   9dcd936c Merge tag 'for-4.19/dm-fixes-4' of git://git.kern..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1007a69b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fba69b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=a979743610b4755d4d57
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fcd826400000

Reported-by: syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com
Fixes: e32d99af6830 ("ASoC: meson: add axg fifos DT binding documentation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
