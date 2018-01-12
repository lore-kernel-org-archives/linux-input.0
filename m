From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Input: trackpoint - force 3 buttons if 0 button is
 reported
Date: Fri, 12 Jan 2018 20:45:17 +0800
Message-ID: <06bbeca0-8a90-8935-9be3-f154db0b9fe9@canonical.com>
References: <20180112064658.25019-1-aaron.ma@canonical.com>
 <20180112083940.p36qj6ltzzwtuhng@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112083940.p36qj6ltzzwtuhng@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Only this laptop had been confirmed is ALPS: 0102 – FF02 trackpoint, it
return 0 of extended button.
I saw the other device that returned 0, but don't have it now, so the ID
can not be checked.

ThinkPad always have 3 buttons installed, I suggest always set 0x33 for
button info when the button info returned 0.
