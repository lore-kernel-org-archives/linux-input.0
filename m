From: Rob Mosher <nyt-fuEpAR7jH0UNb0vsIHg089HuzzzSOjJt@public.gmane.org>
Subject: Re: ti_am33x_adc sampling bugs
Date: Mon, 31 Mar 2014 00:04:47 -0400
Message-ID: <5338E95F.50204@countercultured.net>
References: <53379DF2.7050004@rznt.com> <5337B3F4.30500@countercultured.net> <CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAExKytzRv4CT9zTor=-fc5Mfv+xG9uTjQP=LWosVnhEHsa9Y0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgbalbi-l0cyMroinI0@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

(sorry for the duplicate, got bounces due to HTML encoding)

The specified patch is already included.  The system was running the 
latest kernel from Robert Nelson's repo.  Any suggestions?  I'll try 
removing some of the patches to see if it fixes this behavior.  I have a 
feeling I know which one is doing it.

Thanks.

output from running patch.sh with source pulled from 
https://github.com/beagleboard/kernel/tree/3.8

/home/bbuild/comp/kernel/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch: 
applied

Just in case, I built and installed the kernel and the same behavior 
persisted.

root@rbone:/# uname -a
Linux rbone 3.8.13-00737-g7dfad77 #1 SMP Sun Mar 30 22:11:44 EDT 2014 
armv7l GNU/Linux

gpio30 is connected to AIN4 using a voltage divider

root@rbone:/# cd /sys/class/gpio/
root@rbone:/sys/class/gpio# echo 30 > export
root@rbone:/sys/class/gpio# echo BB-ADC > /sys/devices/bone_capemgr.9/slots
root@rbone:/sys/class/gpio# cd /sys/devices/ocp.3/helper.11/
root@rbone:/sys/devices/ocp.3/helper.11# echo out > 
/sys/class/gpio/gpio30/direction

root@rbone:/sys/devices/ocp.3/helper.11# echo 1 > 
/sys/class/gpio/gpio30/value
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
1460

root@rbone:/sys/devices/ocp.3/helper.11# echo 0 > 
/sys/class/gpio/gpio30/value
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0

root@rbone:/sys/devices/ocp.3/helper.11# grep . AIN[0-3] AIN[5-7]
AIN0:1550
AIN1:1213
AIN2:1485
AIN3:795
AIN5:513
AIN6:744
AIN7:1698

root@rbone:/sys/devices/ocp.3/helper.11# echo 1 > 
/sys/class/gpio/gpio30/value
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
0
root@rbone:/sys/devices/ocp.3/helper.11# cat AIN4
1460

On 3/30/2014 9:16 AM, Zubair Lutfullah wrote:
> https://github.com/beagleboard/kernel/blob/3.8/patches/adc/0017-IIO-ADC-ti_adc-Fix-1st-sample-read.patch
> IIRC, this patch fixes this issue
>
> Can you compile the kernel from the sources and check?
> https://github.com/beagleboard/kernel/tree/3.8
>
> Regards
> ZubairLK
>
> On Sun, Mar 30, 2014 at 7:04 AM, Rob Mosher <nyt-fuEpAR7jH0UNb0vsIHg089HuzzzSOjJt@public.gmane.org 
> <mailto:nyt-fuEpAR7jH0UNb0vsIHg089HuzzzSOjJt@public.gmane.org>> wrote:
>
>     Just a note, the same behavior persists with BB-ADC dtb and
>     reading from in_voltage4_raw
>
>
>     On 3/30/2014 12:30 AM, Rob Mosher wrote:
>
>         Hello fine developers,
>
>         It seems I've stumbled upon a problem while developing a full
>         featured Ruby gem for the Beaglebone.
>
>         It seems a patch included in the beaglebone kernel causes some
>         issues while reading analog inputs.  Apparently the samples
>         get backlogged by the number of adc pins in use.  I'm not sure
>         which patch exactly as there are a number that affect adc
>         buffering and I'm not currently setup for kernel building,
>         however the below output should detail the problem.
>
>         Using the official Debian image.
>         Linux rbone 3.8.13-bone43 #1 SMP Wed Mar 26 14:21:39 UTC 2014
>         armv7l GNU/Linux
>
>         Distributor ID: Debian
>         Description:    Debian GNU/Linux 7.4 (wheezy)
>         Release:        7.4
>         Codename:       wheezy
>
>         root@rbone:~# echo cape-bone-iio >
>         /sys/devices/bone_capemgr.9/slots
>
>         This is the normal and expected behavior.
>
>         1.8v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         0v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>         1.8v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         0v applied to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>         So far working as intended....  Now reading from the other pins.
>
>         root@rbone:/sys/devices/ocp.3/helper.12# grep . AIN[0-3] AIN[5-7]
>         AIN0:1563
>         AIN1:1221
>         AIN2:1487
>         AIN3:789
>         AIN5:514
>         AIN6:743
>         AIN7:1698
>
>         Now applying 1.8v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         Now applying 0v to AIN4
>
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>
>
>         And another example, showing relation to the number of pins in
>         use.
>
>         1.8v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# grep . AIN[0-3]
>         AIN0:1697
>         AIN1:1298
>         AIN2:1524
>         AIN3:816
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         0v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1460
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>
>         1.8v to AIN4
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         0
>         root@rbone:/sys/devices/ocp.3/helper.12# cat AIN4
>         1798
>
>         -- 
>         Rob Mosher
>         Senior Network and Software Engineer
>         Hurricane Electric / AS6939
>
>
>
>
>
