From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
Date: Sat, 28 Apr 2018 11:37:11 +0900
Message-ID: <ac8e7097-eb86-b938-6f18-769d05d46d3c@I-love.SAKURA.ne.jp>
References: <0000000000008bce26056a7a6c23@google.com>
 <CAKdAkRRyRPEnghR6YqE++-H=HJbFL0ejK73Z_vMp_TMyNTT4ew@mail.gmail.com>
 <20180424125541.GB4189@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424125541.GB4189@thunk.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com>, syzkaller-bugs@googlegroups.com
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
List-Id: linux-input@vger.kernel.org

OK. Patch was sent to linux.git as 6c1e851c4edc13a4.

#syz fix: random: fix possible sleeping allocation from irq context
