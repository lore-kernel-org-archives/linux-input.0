From: "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Thu, 15 Feb 2007 20:53:43 +0100
Message-ID: <op.tns2vtwga64tfs@localhost>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com> <op.tns2alf2a64tfs@localhost> <d120d5000702151142l5dca88f7nc71f58473fa27040@mail.gmail.com> <d120d5000702151146p417bd326wd4c212015bf77f25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000702151146p417bd326wd4c212015bf77f25@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

I guess both steering wheels share the same model ID? I don't know, but I  
can tell the FFB didn't work until i added that line and recompiled my  
kernel. I got the ID using the "usbview" tool.

On Thu, 15 Feb 2007 20:46:38 +0100, Dmitry Torokhov  
<dmitry.torokhov@gmail.com> wrote:

> On 2/15/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> On 2/15/07, STenyaK (Bruno Gonzalez) <stenyak@gmail.com> wrote:
>> > Sorry for not providing a proper patch, could you please also add
>> >         {0x46d, 0xc294, hid_lgff_init}, // Logitech G25 wheel
>> > to the list? I tested it here and that wheel is also working.
>> >
>>
>> OK.
>
> Wait, 0x46d:0xc294 is device being added by the original patch as
> Formula Force EX... Confused.
>



-- 
Saludos,
     STenyaK

_______________________________________________
Site:   http://1ksurvivor.homeip.net  <1kSurvivor>
         http://motorsport-sim.org     <Motorsport>
         http://kwh.iespana.es         <KuantikalWareHouse>
         http://emuletutorial.info     <EmuleTutorial>
ICQ:    153709484
Mail:   stenyak AT gmail DOT net
