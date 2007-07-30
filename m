From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in
 hid-lgff.c or hid-tmff.c
Date: Mon, 30 Jul 2007 15:13:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707301512360.26532@jikos.suse.cz>
References: <469B7721.9070705@free.fr>  <d120d5000707160905l214a6ec3yaefc73be5644e1b1@mail.gmail.com>
  <469BA787.8080700@free.fr>  <d120d5000707161350v782563e8na7ae4f593e0daf83@mail.gmail.com>
  <d120d5000707161403v13fa3d0dy3ae730e28fbad174@mail.gmail.com>
 <d120d5000707161421m6c1f6728mb7204093ff1d94da@mail.gmail.com>
 <469C886D.4080401@free.fr> <d120d5000707170650t1cfffa6cofd35263b09157b57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707170650t1cfffa6cofd35263b09157b57@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gerald Folcher <geraldf2@free.fr>, linux-input@atrey.karlin.mff.cuni.cz, Anssi Hannula <anssi.hannula@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 17 Jul 2007, Dmitry Torokhov wrote:

> > Ok, great, I tried both patches alternatively (this last one from
> > Dmitry, and the previous Anssi's one) and they both worked well for my
> > Thrustmaster FGT Force Feedback wheel (tested with the fftest,
> > ffcfstress, and ffmvforce utilities).
> > Thanks you both for doing patches so fast :)
> Thank you for testing. Jiri, please consider adding to your tree.

Hi,

sorry for late reply, I was offline on vacation.

I have fixed a minor typo in the patch changelog and applied it to my 
tree, thanks a lot.

-- 
Jiri Kosina
SUSE Labs
