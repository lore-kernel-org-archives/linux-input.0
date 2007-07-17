From: Gerald Folcher <geraldf2@free.fr>
Subject: Re: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in hid-lgff.c
 or hid-tmff.c
Date: Tue, 17 Jul 2007 11:14:21 +0200
Message-ID: <469C886D.4080401@free.fr>
References: <469B7721.9070705@free.fr>	 <d120d5000707160905l214a6ec3yaefc73be5644e1b1@mail.gmail.com>	 <469BA787.8080700@free.fr>	 <d120d5000707161350v782563e8na7ae4f593e0daf83@mail.gmail.com>	 <d120d5000707161403v13fa3d0dy3ae730e28fbad174@mail.gmail.com> <d120d5000707161421m6c1f6728mb7204093ff1d94da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707161421m6c1f6728mb7204093ff1d94da@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Anssi Hannula <anssi.hannula@gmail.com>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Not quite what I wanted either, what about this one?

Ok, great, I tried both patches alternatively (this last one from 
Dmitry, and the previous Anssi's one) and they both worked well for my 
Thrustmaster FGT Force Feedback wheel (tested with the fftest, 
ffcfstress, and ffmvforce utilities).

Thanks you both for doing patches so fast :)

(OT: Btw, I'm sorry for the delay, I wanted to test it ASAP but ran into 
problems after upgrading the kernel with a something-git7 patch, it 
wouldn't compile (don't worry it's completely unrelated to your 
patches). Finally, after trying numerous unfruitful random things, I was 
able to compile after getting a very recent version of the kernel tree 
using git.)

Thanks.

-- 
Gerald Folcher
