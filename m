From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in
 hid-lgff.c or hid-tmff.c
Date: Wed, 22 Aug 2007 10:16:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708221015190.7792@jikos.suse.cz>
References: <469B7721.9070705@free.fr>  <d120d5000707160905l214a6ec3yaefc73be5644e1b1@mail.gmail.com>
  <469BA787.8080700@free.fr>  <d120d5000707161350v782563e8na7ae4f593e0daf83@mail.gmail.com>
  <d120d5000707161403v13fa3d0dy3ae730e28fbad174@mail.gmail.com>
 <d120d5000707161421m6c1f6728mb7204093ff1d94da@mail.gmail.com>
 <469C886D.4080401@free.fr> <d120d5000707170650t1cfffa6cofd35263b09157b57@mail.gmail.com>
 <Pine.LNX.4.64.0707301512360.26532@jikos.suse.cz> <46CB9FBC.1080002@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46CB9FBC.1080002@free.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Gerald Folcher <geraldf2@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Anssi Hannula <anssi.hannula@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, 22 Aug 2007, Gerald Folcher wrote:

> Please excuse my probable lack of a clue, but does that mean it is in 
> the "HID development tree" ? Because I looked using the web interface at 
> http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=tree;f=drivers/hid/usbhid;h=ada3794226b04c38854c4c5bd8813a85e02328a2;hb=HEAD 
> and the hid-ff.c and hid-tmff.c files there seems to not include the 
> changes. (?)

Hi Gerald,

you were looking at the 'master' branch of the tree, but the patch is 
comitted in the 'upstream' branch -- please look at 
http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=upstream

-- 
Jiri Kosina
SUSE Labs
