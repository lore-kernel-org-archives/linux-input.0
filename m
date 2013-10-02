From: Stefano Statuti <stefano.statuti@hotmail.it>
Subject: [hp mini 210-1000] touchpad "jump" when try to select elements
Date: Wed, 2 Oct 2013 19:18:02 +0200
Message-ID: <DUB107-W2FBB2BE55767E7EC049E483160@phx.gbl>
References: <DUB107-W218244B0D96AE500A24417832B0@phx.gbl>,<DUB107-W50292E6A87D9E3761EA683832B0@phx.gbl>,<DUB107-W48CA14D4723A8FA01E534983150@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <DUB107-W48CA14D4723A8FA01E534983150@phx.gbl>
Sender: owner-linux-aio@kvack.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "christopher.m.penalver@gmail.com" <christopher.m.penalver@gmail.com>
List-Id: linux-input@vger.kernel.org

[1.] One line summary of the problem: =0A=
=0A=
 [hp mini 210-1000] touch pad "jump" when try to select elements=0A=
=0A=
 =0A=
=0A=
 [2.] Full description of the problem/report: =0A=
=0A=
=A0=A0=A0 1) if i click on left button and try to select (using 2 different=
 =0A=
=A0=A0=A0=A0=A0=A0=A0 fingers) some element (like word in a website) the ic=
on of mouse has a =0A=
=A0=A0=A0=A0=A0 strange comportament=2C "jump".=0A=
=0A=
=A0=A0=A0=A0=A0 mouse is this _http://h10032.www1.hp.com/ctg/Manual/c022415=
65.pdf page n=B0 14=0A=
=A0=0A=
=A0=A0 2) if i try to put my finger into touchpad on "Left touchpad button"=
 (or =0A=
=A0=A0=A0=A0=A0=A0=A0 Right touchpad button) and try to scroll my finger ov=
er the button the =0A=
=A0=A0=A0=A0=A0=A0=A0 mouse's pointer moves=2C instead it should not!=0A=
=A0=0A=
=A0=A0 3) in this mouse there is a led (TouchPad on/off button) but NOT =0A=
=A0 =A0 =A0=A0 work. From manual I have this description : "Turns the Touch=
 Pad on and=0A=
 off. Quickly double-tap the button to turn=A0=A0=A0=A0=A0=A0=A0=A0=A0 the =
TouchPad on and off."=0A=
=0A=
=0A=
 =0A=
=0A=
 [3.] Keywords (i.e.=2C modules=2C networking=2C kernel): Please do not put=
 =0A=
anything here. This is how Kernel.org uses an undocumented keyword =0A=
system then the Ubuntu Tags system. =0A=
=0A=
 =0A=
=0A=
 [4.] Kernel version (from /proc/version): =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ cat /proc/version=0A=
Linux version 3.12.0-031200rc3-generic (apw@gomeisa) (gcc version 4.6.3 (Ub=
untu/Linaro 4.6.3-1ubuntu5) ) #201309291835 SMP Sun Sep 29 22:46:02 UTC 201=
3=0A=
annalisa@annalisa-HP-Mini-210-1000:~$=0A=
=0A=
 =0A=
=0A=
 [5.] Output of Oops.. message (if applicable) with symbolic information re=
solved (see Documentation/oops-tracing.txt) =0A=
=0A=
 This is only relevant if you had a oops crash (ex. flashing Caps Lock ligh=
t). While booted into the newest upstream mainline kernel only=2C if you ha=
ve a kernel oops=2C one may consult http://www.kernel.org/doc/Documentation=
/oops-tracing.txt . If this is too daunting please ask for help in your bug=
 report=2C and of the Ubuntu community. =0A=
=0A=
 =0A=
=0A=
 [6.] A small shell script or example program which triggers the problem (i=
f possible) =0A=
=0A=
 This is for advanced community members. If you feel comfortable enough =0A=
to do this=2C please do it. It is not crtical if this is beyond your skill=
=0A=
 level. =0A=
=0A=
 =0A=
=0A=
 [7.] Environment =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ lsb_release -rd=0A=
Description:=A0=A0=A0 Ubuntu 13.04=0A=
Release:=A0=A0=A0 13.04=0A=
=0A=
 =0A=
=0A=
 [7.1.] Software (add the output of the ver_linux script here) =0A=
=0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ /usr/src/linux-headers-3.12.0-031200=
rc3/scripts/ver_linux=0A=
If some fields are empty or look unusual you may have an old version.=0A=
Compare to the current minimal requirements in Documentation/Changes.=0A=
=A0=0A=
Linux annalisa-HP-Mini-210-1000 3.12.0-031200rc3-generic #201309291835 SMP =
Sun Sep 29 22:46:02 UTC 2013 i686 i686 i686 GNU/Linux=0A=
=A0=0A=
Gnu C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4.7=0A=
Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.81=0A=
binutils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.23.2=0A=
util-linux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.20.1=0A=
mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 support=0A=
module-init-tools=A0=A0=A0=A0=A0 9=0A=
e2fsprogs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.42.5=0A=
pcmciautils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 018=0A=
PPP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.4.5=0A=
Linux C Library=A0=A0=A0=A0=A0=A0=A0 2.17=0A=
Dynamic linker (ldd)=A0=A0 2.17=0A=
Procps=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.3.3=0A=
Net-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.60=0A=
Kbd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.15.5=0A=
Sh-utils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8.20=0A=
wireless-tools=A0=A0=A0=A0=A0=A0=A0=A0 30=0A=
Modules Loaded=A0=A0=A0=A0=A0=A0=A0=A0 snd_hda_codec_idt snd_hda_intel joyd=
ev snd_hda_codec snd_hwdep hp_wmi sparse_keymap snd_pcm snd_page_alloc snd_=
seq_midi snd_seq_midi_event parport_pc snd_rawmidi ppdev i915 rfcomm bnep b=
luetooth snd_seq drm_kms_helper uvcvideo snd_seq_device videobuf2_vmalloc v=
ideobuf2_memops snd_timer videobuf2_core psmouse videodev drm video wmi snd=
 serio_raw mac_hid i2c_algo_bit lp soundcore parport lpc_ich ahci r8169 lib=
ahci mii=0A=
=A0=0A=
=0A=
 =0A=
=0A=
 [7.2.] Processor information (from /proc/cpuinfo): =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ cat /proc/cpuinfo=0A=
processor=A0=A0=A0 : 0=0A=
vendor_id=A0=A0=A0 : GenuineIntel=0A=
cpu family=A0=A0=A0 : 6=0A=
model=A0=A0=A0 =A0=A0=A0 : 28=0A=
model name=A0=A0=A0 : Intel(R) Atom(TM) CPU N450=A0=A0 @ 1.66GHz=0A=
stepping=A0=A0=A0 : 10=0A=
microcode=A0=A0=A0 : 0x105=0A=
cpu MHz=A0=A0=A0 =A0=A0=A0 : 1000.000=0A=
cache size=A0=A0=A0 : 512 KB=0A=
physical id=A0=A0=A0 : 0=0A=
siblings=A0=A0=A0 : 2=0A=
core id=A0=A0=A0 =A0=A0=A0 : 0=0A=
cpu cores=A0=A0=A0 : 1=0A=
apicid=A0=A0=A0 =A0=A0=A0 : 0=0A=
initial apicid=A0=A0=A0 : 0=0A=
fdiv_bug=A0=A0=A0 : no=0A=
f00f_bug=A0=A0=A0 : no=0A=
coma_bug=A0=A0=A0 : no=0A=
fpu=A0=A0=A0 =A0=A0=A0 : yes=0A=
fpu_exception=A0=A0=A0 : yes=0A=
cpuid level=A0=A0=A0 : 10=0A=
wp=A0=A0=A0 =A0=A0=A0 : yes=0A=
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm con=
stant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm=
2 ssse3 cx16 xtpr pdcm movbe lahf_lm dtherm=0A=
bogomips=A0=A0=A0 : 3324.89=0A=
clflush size=A0=A0=A0 : 64=0A=
cache_alignment=A0=A0=A0 : 64=0A=
address sizes=A0=A0=A0 : 32 bits physical=2C 48 bits virtual=0A=
power management:=0A=
=0A=
processor=A0=A0=A0 : 1=0A=
vendor_id=A0=A0=A0 : GenuineIntel=0A=
cpu family=A0=A0=A0 : 6=0A=
model=A0=A0=A0 =A0=A0=A0 : 28=0A=
model name=A0=A0=A0 : Intel(R) Atom(TM) CPU N450=A0=A0 @ 1.66GHz=0A=
stepping=A0=A0=A0 : 10=0A=
microcode=A0=A0=A0 : 0x105=0A=
cpu MHz=A0=A0=A0 =A0=A0=A0 : 1000.000=0A=
cache size=A0=A0=A0 : 512 KB=0A=
physical id=A0=A0=A0 : 0=0A=
siblings=A0=A0=A0 : 2=0A=
core id=A0=A0=A0 =A0=A0=A0 : 0=0A=
cpu cores=A0=A0=A0 : 1=0A=
apicid=A0=A0=A0 =A0=A0=A0 : 1=0A=
initial apicid=A0=A0=A0 : 1=0A=
fdiv_bug=A0=A0=A0 : no=0A=
f00f_bug=A0=A0=A0 : no=0A=
coma_bug=A0=A0=A0 : no=0A=
fpu=A0=A0=A0 =A0=A0=A0 : yes=0A=
fpu_exception=A0=A0=A0 : yes=0A=
cpuid level=A0=A0=A0 : 10=0A=
wp=A0=A0=A0 =A0=A0=A0 : yes=0A=
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm con=
stant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm=
2 ssse3 cx16 xtpr pdcm movbe lahf_lm dtherm=0A=
bogomips=A0=A0=A0 : 3324.89=0A=
clflush size=A0=A0=A0 : 64=0A=
cache_alignment=A0=A0=A0 : 64=0A=
address sizes=A0=A0=A0 : 32 bits physical=2C 48 bits virtual=0A=
power management:=0A=
=0A=
=0A=
=0A=
 [7.3.] Module information (from /proc/modules): =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ cat /proc/modules=0A=
snd_hda_codec_idt 45153 1 - Live 0x00000000=0A=
snd_hda_intel 43367 3 - Live 0x00000000=0A=
joydev 17299 0 - Live 0x00000000=0A=
snd_hda_codec 169632 2 snd_hda_codec_idt=2Csnd_hda_intel=2C Live 0x00000000=
=0A=
snd_hwdep 13276 1 snd_hda_codec=2C Live 0x00000000=0A=
hp_wmi 17834 0 - Live 0x00000000=0A=
sparse_keymap 13658 1 hp_wmi=2C Live 0x00000000=0A=
snd_pcm 90501 2 snd_hda_intel=2Csnd_hda_codec=2C Live 0x00000000=0A=
snd_page_alloc 18398 2 snd_hda_intel=2Csnd_pcm=2C Live 0x00000000=0A=
snd_seq_midi 13132 0 - Live 0x00000000=0A=
snd_seq_midi_event 14475 1 snd_seq_midi=2C Live 0x00000000=0A=
parport_pc 32114 0 - Live 0x00000000=0A=
snd_rawmidi 25198 1 snd_seq_midi=2C Live 0x00000000=0A=
ppdev 17423 0 - Live 0x00000000=0A=
i915 656767 3 - Live 0x00000000=0A=
rfcomm 59026 0 - Live 0x00000000=0A=
bnep 19143 2 - Live 0x00000000=0A=
bluetooth 337865 10 rfcomm=2Cbnep=2C Live 0x00000000=0A=
snd_seq 55716 2 snd_seq_midi=2Csnd_seq_midi_event=2C Live 0x00000000=0A=
drm_kms_helper 47293 1 i915=2C Live 0x00000000=0A=
uvcvideo 72275 0 - Live 0x00000000=0A=
snd_seq_device 14137 3 snd_seq_midi=2Csnd_rawmidi=2Csnd_seq=2C Live 0x00000=
000=0A=
videobuf2_vmalloc 13048 1 uvcvideo=2C Live 0x00000000=0A=
videobuf2_memops 13170 1 videobuf2_vmalloc=2C Live 0x00000000=0A=
snd_timer 28971 2 snd_pcm=2Csnd_seq=2C Live 0x00000000=0A=
videobuf2_core 39479 1 uvcvideo=2C Live 0x00000000=0A=
psmouse 92689 0 - Live 0x00000000=0A=
videodev 108525 2 uvcvideo=2Cvideobuf2_core=2C Live 0x00000000=0A=
drm 248440 4 i915=2Cdrm_kms_helper=2C Live 0x00000000=0A=
video 19046 1 i915=2C Live 0x00000000=0A=
wmi 18827 1 hp_wmi=2C Live 0x00000000=0A=
snd 61311 16 snd_hda_codec_idt=2Csnd_hda_intel=2Csnd_hda_codec=2Csnd_hwdep=
=2Csnd_pcm=2Csnd_seq_midi=2Csnd_rawmidi=2Csnd_seq=2Csnd_seq_device=2Csnd_ti=
mer=2C Live 0x00000000=0A=
serio_raw 13230 0 - Live 0x00000000=0A=
mac_hid 13077 0 - Live 0x00000000=0A=
i2c_algo_bit 13316 1 i915=2C Live 0x00000000=0A=
lp 13359 0 - Live 0x00000000=0A=
soundcore 12600 1 snd=2C Live 0x00000000=0A=
parport 40945 3 parport_pc=2Cppdev=2Clp=2C Live 0x00000000=0A=
lpc_ich 16987 0 - Live 0x00000000=0A=
ahci 25703 2 - Live 0x00000000=0A=
r8169 62775 0 - Live 0x00000000=0A=
libahci 30834 1 ahci=2C Live 0x00000000=0A=
mii 13693 1 r8169=2C Live 0x00000000=0A=
=0A=
=0A=
 =0A=
=0A=
 [7.4.] Loaded driver and hardware information (/proc/ioports=2C /proc/iome=
m) =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ cat /proc/ioports=0A=
0000-0cf7 : PCI Bus 0000:00=0A=
=A0 0000-001f : dma1=0A=
=A0 0020-0021 : pic1=0A=
=A0 0040-0043 : timer0=0A=
=A0 0050-0053 : timer1=0A=
=A0 0060-0060 : keyboard=0A=
=A0 0062-0062 : EC data=0A=
=A0 0064-0064 : keyboard=0A=
=A0 0066-0066 : EC cmd=0A=
=A0 0070-0077 : rtc0=0A=
=A0 0080-008f : dma page reg=0A=
=A0 00a0-00a1 : pic2=0A=
=A0 00c0-00df : dma2=0A=
=A0 00f0-00ff : fpu=0A=
=A0 0380-0387 : pnp 00:00=0A=
=A0 0400-0403 : ACPI PM1a_EVT_BLK=0A=
=A0 0404-0405 : ACPI PM1a_CNT_BLK=0A=
=A0 0408-040b : ACPI PM_TMR=0A=
=A0 0410-0415 : ACPI CPU throttle=0A=
=A0 0420-0420 : ACPI PM2_CNT_BLK=0A=
=A0 0428-042f : ACPI GPE0_BLK=0A=
=A0 0430-0433 : iTCO_wdt=0A=
=A0 0460-047f : iTCO_wdt=0A=
=A0 0500-053f : pnp 00:00=0A=
=A0 0600-060f : pnp 00:00=0A=
=A0 0610-0610 : pnp 00:00=0A=
=A0 0800-080f : pnp 00:00=0A=
=A0 0810-0817 : pnp 00:00=0A=
0cf8-0cff : PCI conf1=0A=
0d00-ffff : PCI Bus 0000:00=0A=
=A0 164e-164f : pnp 00:00=0A=
=A0 4000-4fff : PCI Bus 0000:02=0A=
=A0 5000-5fff : PCI Bus 0000:01=0A=
=A0=A0=A0 5000-50ff : 0000:01:00.0=0A=
=A0=A0=A0=A0=A0 5000-50ff : r8169=0A=
=A0 6000-601f : 0000:00:1f.3=0A=
=A0 6020-603f : 0000:00:1d.3=0A=
=A0=A0=A0 6020-603f : uhci_hcd=0A=
=A0 6040-605f : 0000:00:1d.2=0A=
=A0=A0=A0 6040-605f : uhci_hcd=0A=
=A0 6060-607f : 0000:00:1d.1=0A=
=A0=A0=A0 6060-607f : uhci_hcd=0A=
=A0 6080-609f : 0000:00:1d.0=0A=
=A0=A0=A0 6080-609f : uhci_hcd=0A=
=A0 60a0-60af : 0000:00:1f.2=0A=
=A0=A0=A0 60a0-60af : ahci=0A=
=A0 60b0-60b7 : 0000:00:1f.2=0A=
=A0=A0=A0 60b0-60b7 : ahci=0A=
=A0 60b8-60bf : 0000:00:1f.2=0A=
=A0=A0=A0 60b8-60bf : ahci=0A=
=A0 60c0-60c7 : 0000:00:02.0=0A=
=A0 60c8-60cb : 0000:00:1f.2=0A=
=A0=A0=A0 60c8-60cb : ahci=0A=
=A0 60cc-60cf : 0000:00:1f.2=0A=
=A0=A0=A0 60cc-60cf : ahci=0A=
=0A=
annalisa@annalisa-HP-Mini-210-1000:~$ cat /proc/iomem=0A=
00000000-00000fff : reserved=0A=
00001000-0009fbff : System RAM=0A=
0009fc00-0009ffff : reserved=0A=
000a0000-000bffff : PCI Bus 0000:00=0A=
=A0 000a0000-000bffff : Video RAM area=0A=
000c0000-000c7fff : Video ROM=0A=
000e0000-000fffff : reserved=0A=
=A0 000f0000-000fffff : System ROM=0A=
00100000-3f493fff : System RAM=0A=
=A0 01000000-0168fad6 : Kernel code=0A=
=A0 0168fad7-019f897f : Kernel data=0A=
=A0 01adb000-01bcefff : Kernel bss=0A=
3f494000-3f575fff : reserved=0A=
3f576000-3f5befff : ACPI Non-volatile Storage=0A=
3f5bf000-3f5e9fff : reserved=0A=
3f5ea000-3f5fefff : ACPI Tables=0A=
3f5ff000-3fffffff : reserved=0A=
=A0 3f800000-3fffffff : Graphics Stolen Memory=0A=
40000000-febfffff : PCI Bus 0000:00=0A=
=A0 40000000-4fffffff : 0000:00:02.0=0A=
=A0 50000000-50ffffff : PCI Bus 0000:01=0A=
=A0=A0=A0 50000000-5000ffff : 0000:01:00.0=0A=
=A0=A0=A0=A0=A0 50000000-5000ffff : r8169=0A=
=A0=A0=A0 50010000-50010fff : 0000:01:00.0=0A=
=A0=A0=A0=A0=A0 50010000-50010fff : r8169=0A=
=A0=A0=A0 50020000-5002ffff : 0000:01:00.0=0A=
=A0 51000000-51ffffff : PCI Bus 0000:02=0A=
=A0 52000000-52000fff : Intel Flush Page=0A=
=A0 52004000-52007fff : i915 MCHBAR=0A=
=A0 56000000-56ffffff : PCI Bus 0000:02=0A=
=A0=A0=A0 56000000-56003fff : 0000:02:00.0=0A=
=A0 57000000-57ffffff : PCI Bus 0000:01=0A=
=A0 58000000-580fffff : 0000:00:02.0=0A=
=A0 58100000-5817ffff : 0000:00:02.1=0A=
=A0 58180000-581fffff : 0000:00:02.0=0A=
=A0 58200000-58203fff : 0000:00:1b.0=0A=
=A0=A0=A0 58200000-58203fff : ICH HD audio=0A=
=A0 58204000-582043ff : 0000:00:1f.2=0A=
=A0=A0=A0 58204000-582043ff : ahci=0A=
=A0 58204400-582047ff : 0000:00:1d.7=0A=
=A0=A0=A0 58204400-582047ff : ehci_hcd=0A=
=A0 e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]=0A=
=A0=A0=A0 e0000000-efffffff : reserved=0A=
=A0=A0=A0=A0=A0 e0000000-efffffff : pnp 00:00=0A=
fec00000-fec00fff : reserved=0A=
=A0 fec00000-fec003ff : IOAPIC 0=0A=
fed00000-fed003ff : HPET 0=0A=
fed14000-fed19fff : reserved=0A=
=A0 fed14000-fed17fff : pnp 00:00=0A=
=A0 fed18000-fed18fff : pnp 00:00=0A=
=A0 fed19000-fed19fff : pnp 00:00=0A=
fed1c000-fed1ffff : reserved=0A=
=A0 fed1c000-fed1ffff : pnp 00:00=0A=
=A0=A0=A0 fed1f410-fed1f414 : iTCO_wdt=0A=
fee00000-fee00fff : Local APIC=0A=
=A0 fee00000-fee00fff : reserved=0A=
=A0=A0=A0 fee00000-fee00fff : pnp 00:00=0A=
ffe00000-ffffffff : reserved=0A=
=0A=
=0A=
 =0A=
=0A=
 [7.5.] PCI information ('lspci -vvv' as root) =0A=
=0A=
  root@annalisa-HP-Mini-210-1000:/home/annalisa# sudo lspci -vvv=0A=
00:00.0 Host bridge: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx D=
MI Bridge=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort+>SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Capabilities: [e0] Vendor Specific Information: Len=3D08 <?>=0A=
=A0=A0=A0 Kernel driver in use: agpgart-intel=0A=
=0A=
00:02.0 VGA compatible controller: Intel Corporation Atom Processor D4xx/D5=
xx/N4xx/N5xx Integrated Graphics Controller (prog-if 00 [VGA controller])=
=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin A routed to IRQ 44=0A=
=A0=A0=A0 Region 0: Memory at 58180000 (32-bit=2C non-prefetchable) [size=
=3D512K]=0A=
=A0=A0=A0 Region 1: I/O ports at 60c0 [size=3D8]=0A=
=A0=A0=A0 Region 2: Memory at 40000000 (32-bit=2C prefetchable) [size=3D256=
M]=0A=
=A0=A0=A0 Region 3: Memory at 58000000 (32-bit=2C non-prefetchable) [size=
=3D1M]=0A=
=A0=A0=A0 Expansion ROM at <unassigned> [disabled]=0A=
=A0=A0=A0 Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-=0A=
=A0=A0=A0 =A0=A0=A0 Address: fee0300c=A0 Data: 41c1=0A=
=A0=A0=A0 Capabilities: [d0] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-=2C=
D1-=2CD2-=2CD3hot-=2CD3cold-)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Kernel driver in use: i915=0A=
=0A=
00:02.1 Display controller: Intel Corporation Atom Processor D4xx/D5xx/N4xx=
/N5xx Integrated Graphics Controller=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Region 0: Memory at 58100000 (32-bit=2C non-prefetchable) [size=
=3D512K]=0A=
=A0=A0=A0 Capabilities: [d0] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-=2C=
D1-=2CD2-=2CD3hot-=2CD3cold-)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=0A=
00:1b.0 Audio device: Intel Corporation NM10/ICH7 Family High Definition Au=
dio Controller (rev 02)=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=2C Cache Line Size: 64 bytes=0A=
=A0=A0=A0 Interrupt: pin A routed to IRQ 45=0A=
=A0=A0=A0 Region 0: Memory at 58200000 (64-bit=2C non-prefetchable) [size=
=3D16K]=0A=
=A0=A0=A0 Capabilities: [50] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+=
=2CD1-=2CD2-=2CD3hot+=2CD3cold+)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+=0A=
=A0=A0=A0 =A0=A0=A0 Address: 00000000fee0300c=A0 Data: 41d1=0A=
=A0=A0=A0 Capabilities: [70] Express (v1) Root Complex Integrated Endpoint=
=2C MSI 00=0A=
=A0=A0=A0 =A0=A0=A0 DevCap:=A0=A0=A0 MaxPayload 128 bytes=2C PhantFunc 0=2C=
 Latency L0s <64ns=2C L1 <1us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtTag- RBE- FLReset-=0A=
=A0=A0=A0 =A0=A0=A0 DevCtl:=A0=A0=A0 Report errors: Correctable- Non-Fatal-=
 Fatal- Unsupported-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+=
=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 MaxPayload 128 bytes=2C MaxReadReq 128 bytes=
=0A=
=A0=A0=A0 =A0=A0=A0 DevSta:=A0=A0=A0 CorrErr- UncorrErr- FatalErr- UnsuppRe=
q- AuxPwr+ TransPend-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCap:=A0=A0=A0 Port #0=2C Speed unknown=2C Width x0=
=2C ASPM unknown=2C Latency L0 <64ns=2C L1 <1us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ClockPM- Surprise- LLActRep- BwNot-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCtl:=A0=A0=A0 ASPM Disabled=3B Disabled- Retrain- Co=
mmClk-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt=
-=0A=
=A0=A0=A0 =A0=A0=A0 LnkSta:=A0=A0=A0 Speed unknown=2C Width x0=2C TrErr- Tr=
ain- SlotClk- DLActive- BWMgmt- ABWMgmt-=0A=
=A0=A0=A0 Capabilities: [100 v1] Virtual Channel=0A=
=A0=A0=A0 =A0=A0=A0 Caps:=A0=A0=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D=
1=0A=
=A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128-=0A=
=A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 ArbSelect=3DFixed=0A=
=A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable+ ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D01=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC1:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable+ ID=3D1 ArbSelect=3DFix=
ed TC/VC=3D80=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 Capabilities: [130 v1] Root Complex Link=0A=
=A0=A0=A0 =A0=A0=A0 Desc:=A0=A0=A0 PortNumber=3D0f ComponentID=3D02 EltType=
=3DConfig=0A=
=A0=A0=A0 =A0=A0=A0 Link0:=A0=A0=A0 Desc:=A0=A0=A0 TargetPort=3D00 TargetCo=
mponent=3D02 AssocRCRB- LinkType=3DMemMapped LinkValid+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Addr:=A0=A0=A0 00000000fed1c000=0A=
=A0=A0=A0 Kernel driver in use: snd_hda_intel=0A=
=0A=
00:1c.0 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 1 (=
rev 02) (prog-if 00 [Normal decode])=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=2C Cache Line Size: 64 bytes=0A=
=A0=A0=A0 Bus: primary=3D00=2C secondary=3D01=2C subordinate=3D01=2C sec-la=
tency=3D0=0A=
=A0=A0=A0 I/O behind bridge: 00005000-00005fff=0A=
=A0=A0=A0 Memory behind bridge: 57000000-57ffffff=0A=
=A0=A0=A0 Prefetchable memory behind bridge: 0000000050000000-0000000050fff=
fff=0A=
=A0=A0=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort+ <SERR- <PERR-=0A=
=A0=A0=A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort->Reset- FastB2B-=0A=
=A0=A0=A0 =A0=A0=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-=0A=
=A0=A0=A0 Capabilities: [40] Express (v1) Root Port (Slot+)=2C MSI 00=0A=
=A0=A0=A0 =A0=A0=A0 DevCap:=A0=A0=A0 MaxPayload 128 bytes=2C PhantFunc 0=2C=
 Latency L0s unlimited=2C L1 unlimited=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtTag- RBE- FLReset-=0A=
=A0=A0=A0 =A0=A0=A0 DevCtl:=A0=A0=A0 Report errors: Correctable- Non-Fatal-=
 Fatal- Unsupported-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-=
=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 MaxPayload 128 bytes=2C MaxReadReq 128 bytes=
=0A=
=A0=A0=A0 =A0=A0=A0 DevSta:=A0=A0=A0 CorrErr- UncorrErr- FatalErr- UnsuppRe=
q- AuxPwr+ TransPend-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCap:=A0=A0=A0 Port #1=2C Speed 2.5GT/s=2C Width x1=
=2C ASPM L0s L1=2C Latency L0 <256ns=2C L1 <4us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ClockPM- Surprise- LLActRep+ BwNot-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCtl:=A0=A0=A0 ASPM Disabled=3B RCB 64 bytes Disabled=
- Retrain- CommClk+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt=
-=0A=
=A0=A0=A0 =A0=A0=A0 LnkSta:=A0=A0=A0 Speed 2.5GT/s=2C Width x1=2C TrErr- Tr=
ain- SlotClk+ DLActive+ BWMgmt- ABWMgmt-=0A=
=A0=A0=A0 =A0=A0=A0 SltCap:=A0=A0=A0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd=
- HotPlug+ Surprise+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Slot #0=2C PowerLimit 6.500W=3B Interlock- No=
Compl-=0A=
=A0=A0=A0 =A0=A0=A0 SltCtl:=A0=A0=A0 Enable: AttnBtn- PwrFlt- MRL- PresDet-=
 CmdCplt- HPIrq- LinkChg-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Control: AttnInd Unknown=2C PwrInd Unknown=2C=
 Power- Interlock-=0A=
=A0=A0=A0 =A0=A0=A0 SltSta:=A0=A0=A0 Status: AttnBtn- PowerFlt- MRL- CmdCpl=
t- PresDet+ Interlock-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Changed: MRL- PresDet- LinkState+=0A=
=A0=A0=A0 =A0=A0=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEInt=
Ena- CRSVisible-=0A=
=A0=A0=A0 =A0=A0=A0 RootCap: CRSVisible-=0A=
=A0=A0=A0 =A0=A0=A0 RootSta: PME ReqID 0000=2C PMEStatus- PMEPending-=0A=
=A0=A0=A0 Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-=0A=
=A0=A0=A0 =A0=A0=A0 Address: fee0300c=A0 Data: 4181=0A=
=A0=A0=A0 Capabilities: [90] Subsystem: Hewlett-Packard Company Device 3660=
=0A=
=A0=A0=A0 Capabilities: [a0] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+=2C=
D1-=2CD2-=2CD3hot+=2CD3cold+)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Capabilities: [100 v1] Virtual Channel=0A=
=A0=A0=A0 =A0=A0=A0 Caps:=A0=A0=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D=
1=0A=
=A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed+ WRR32- WRR64- WRR128-=0A=
=A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 ArbSelect=3DFixed=0A=
=A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed+ WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable+ ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D01=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC1:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed+ WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable- ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D00=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 Capabilities: [180 v1] Root Complex Link=0A=
=A0=A0=A0 =A0=A0=A0 Desc:=A0=A0=A0 PortNumber=3D01 ComponentID=3D02 EltType=
=3DConfig=0A=
=A0=A0=A0 =A0=A0=A0 Link0:=A0=A0=A0 Desc:=A0=A0=A0 TargetPort=3D00 TargetCo=
mponent=3D02 AssocRCRB- LinkType=3DMemMapped LinkValid+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Addr:=A0=A0=A0 00000000fed1c001=0A=
=A0=A0=A0 Kernel driver in use: pcieport=0A=
=0A=
00:1c.1 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 2 (=
rev 02) (prog-if 00 [Normal decode])=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=2C Cache Line Size: 64 bytes=0A=
=A0=A0=A0 Bus: primary=3D00=2C secondary=3D02=2C subordinate=3D02=2C sec-la=
tency=3D0=0A=
=A0=A0=A0 I/O behind bridge: 00004000-00004fff=0A=
=A0=A0=A0 Memory behind bridge: 56000000-56ffffff=0A=
=A0=A0=A0 Prefetchable memory behind bridge: 0000000051000000-0000000051fff=
fff=0A=
=A0=A0=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort+ <SERR- <PERR-=0A=
=A0=A0=A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort->Reset- FastB2B-=0A=
=A0=A0=A0 =A0=A0=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-=0A=
=A0=A0=A0 Capabilities: [40] Express (v1) Root Port (Slot+)=2C MSI 00=0A=
=A0=A0=A0 =A0=A0=A0 DevCap:=A0=A0=A0 MaxPayload 128 bytes=2C PhantFunc 0=2C=
 Latency L0s unlimited=2C L1 unlimited=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtTag- RBE- FLReset-=0A=
=A0=A0=A0 =A0=A0=A0 DevCtl:=A0=A0=A0 Report errors: Correctable- Non-Fatal-=
 Fatal- Unsupported-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-=
=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 MaxPayload 128 bytes=2C MaxReadReq 128 bytes=
=0A=
=A0=A0=A0 =A0=A0=A0 DevSta:=A0=A0=A0 CorrErr- UncorrErr- FatalErr- UnsuppRe=
q- AuxPwr+ TransPend-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCap:=A0=A0=A0 Port #2=2C Speed 2.5GT/s=2C Width x1=
=2C ASPM L0s L1=2C Latency L0 <256ns=2C L1 <4us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ClockPM- Surprise- LLActRep+ BwNot-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCtl:=A0=A0=A0 ASPM L1 Enabled=3B RCB 64 bytes Disabl=
ed- Retrain- CommClk+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt=
-=0A=
=A0=A0=A0 =A0=A0=A0 LnkSta:=A0=A0=A0 Speed 2.5GT/s=2C Width x1=2C TrErr- Tr=
ain- SlotClk+ DLActive+ BWMgmt- ABWMgmt-=0A=
=A0=A0=A0 =A0=A0=A0 SltCap:=A0=A0=A0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd=
- HotPlug+ Surprise+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Slot #1=2C PowerLimit 6.500W=3B Interlock- No=
Compl-=0A=
=A0=A0=A0 =A0=A0=A0 SltCtl:=A0=A0=A0 Enable: AttnBtn- PwrFlt- MRL- PresDet-=
 CmdCplt- HPIrq- LinkChg-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Control: AttnInd Unknown=2C PwrInd Unknown=2C=
 Power- Interlock-=0A=
=A0=A0=A0 =A0=A0=A0 SltSta:=A0=A0=A0 Status: AttnBtn- PowerFlt- MRL- CmdCpl=
t- PresDet+ Interlock-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Changed: MRL- PresDet+ LinkState+=0A=
=A0=A0=A0 =A0=A0=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEInt=
Ena- CRSVisible-=0A=
=A0=A0=A0 =A0=A0=A0 RootCap: CRSVisible-=0A=
=A0=A0=A0 =A0=A0=A0 RootSta: PME ReqID 0000=2C PMEStatus- PMEPending-=0A=
=A0=A0=A0 Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-=0A=
=A0=A0=A0 =A0=A0=A0 Address: fee0300c=A0 Data: 4191=0A=
=A0=A0=A0 Capabilities: [90] Subsystem: Hewlett-Packard Company Device 3660=
=0A=
=A0=A0=A0 Capabilities: [a0] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+=2C=
D1-=2CD2-=2CD3hot+=2CD3cold+)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Capabilities: [100 v1] Virtual Channel=0A=
=A0=A0=A0 =A0=A0=A0 Caps:=A0=A0=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D=
1=0A=
=A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed+ WRR32- WRR64- WRR128-=0A=
=A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 ArbSelect=3DFixed=0A=
=A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed+ WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable+ ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D01=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC1:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed+ WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable- ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D00=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 Capabilities: [180 v1] Root Complex Link=0A=
=A0=A0=A0 =A0=A0=A0 Desc:=A0=A0=A0 PortNumber=3D02 ComponentID=3D02 EltType=
=3DConfig=0A=
=A0=A0=A0 =A0=A0=A0 Link0:=A0=A0=A0 Desc:=A0=A0=A0 TargetPort=3D00 TargetCo=
mponent=3D02 AssocRCRB- LinkType=3DMemMapped LinkValid+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Addr:=A0=A0=A0 00000000fed1c001=0A=
=A0=A0=A0 Kernel driver in use: pcieport=0A=
=0A=
00:1d.0 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #1 (rev 02) (prog-if 00 [UHCI])=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin A routed to IRQ 16=0A=
=A0=A0=A0 Region 4: I/O ports at 6080 [size=3D32]=0A=
=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=
=0A=
00:1d.1 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #2 (rev 02) (prog-if 00 [UHCI])=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin B routed to IRQ 17=0A=
=A0=A0=A0 Region 4: I/O ports at 6060 [size=3D32]=0A=
=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=
=0A=
00:1d.2 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #3 (rev 02) (prog-if 00 [UHCI])=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin C routed to IRQ 18=0A=
=A0=A0=A0 Region 4: I/O ports at 6040 [size=3D32]=0A=
=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=
=0A=
00:1d.3 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #4 (rev 02) (prog-if 00 [UHCI])=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin D routed to IRQ 19=0A=
=A0=A0=A0 Region 4: I/O ports at 6020 [size=3D32]=0A=
=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=
=0A=
00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI Contro=
ller (rev 02) (prog-if 20 [EHCI])=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin A routed to IRQ 16=0A=
=A0=A0=A0 Region 0: Memory at 58204400 (32-bit=2C non-prefetchable) [size=
=3D1K]=0A=
=A0=A0=A0 Capabilities: [50] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+=
=2CD1-=2CD2-=2CD3hot+=2CD3cold+)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0=0A=
=A0=A0=A0 Kernel driver in use: ehci-pci=0A=
=0A=
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (pro=
g-if 01 [Subtractive decode])=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Bus: primary=3D00=2C secondary=3D05=2C subordinate=3D05=2C sec-la=
tency=3D32=0A=
=A0=A0=A0 I/O behind bridge: 0000f000-00000fff=0A=
=A0=A0=A0 Memory behind bridge: fff00000-000fffff=0A=
=A0=A0=A0 Prefetchable memory behind bridge: 00000000fff00000-00000000000ff=
fff=0A=
=A0=A0=A0 Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort+ <SERR- <PERR-=0A=
=A0=A0=A0 BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort->Reset- FastB2B-=0A=
=A0=A0=A0 =A0=A0=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-=0A=
=A0=A0=A0 Capabilities: [50] Subsystem: Hewlett-Packard Company Device 3660=
=0A=
=0A=
00:1f.0 ISA bridge: Intel Corporation NM10 Family LPC Controller (rev 02)=
=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>=0A=
=A0=A0=A0 Kernel driver in use: lpc_ich=0A=
=0A=
00:1f.2 SATA controller: Intel Corporation NM10/ICH7 Family SATA Controller=
 [AHCI mode] (rev 02) (prog-if 01 [AHCI 1.0])=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+=0A=
=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=0A=
=A0=A0=A0 Interrupt: pin B routed to IRQ 43=0A=
=A0=A0=A0 Region 0: I/O ports at 60b8 [size=3D8]=0A=
=A0=A0=A0 Region 1: I/O ports at 60cc [size=3D4]=0A=
=A0=A0=A0 Region 2: I/O ports at 60b0 [size=3D8]=0A=
=A0=A0=A0 Region 3: I/O ports at 60c8 [size=3D4]=0A=
=A0=A0=A0 Region 4: I/O ports at 60a0 [size=3D16]=0A=
=A0=A0=A0 Region 5: Memory at 58204000 (32-bit=2C non-prefetchable) [size=
=3D1K]=0A=
=A0=A0=A0 Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-=0A=
=A0=A0=A0 =A0=A0=A0 Address: fee0300c=A0 Data: 41b1=0A=
=A0=A0=A0 Capabilities: [70] Power Management version 2=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-=2C=
D1-=2CD2-=2CD3hot+=2CD3cold-)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Kernel driver in use: ahci=0A=
=0A=
00:1f.3 SMBus: Intel Corporation NM10/ICH7 Family SMBus Controller (rev 02)=
=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort-=
 <TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Interrupt: pin B routed to IRQ 10=0A=
=A0=A0=A0 Region 4: I/O ports at 6000 [size=3D32]=0A=
=0A=
01:00.0 Ethernet controller: Realtek Semiconductor Co.=2C Ltd. RTL8101E/RTL=
8102E PCI Express Fast Ethernet controller (rev 02)=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 3660=0A=
=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=2C Cache Line Size: 64 bytes=0A=
=A0=A0=A0 Interrupt: pin A routed to IRQ 42=0A=
=A0=A0=A0 Region 0: I/O ports at 5000 [size=3D256]=0A=
=A0=A0=A0 Region 2: Memory at 50010000 (64-bit=2C prefetchable) [size=3D4K]=
=0A=
=A0=A0=A0 Region 4: Memory at 50000000 (64-bit=2C prefetchable) [size=3D64K=
]=0A=
=A0=A0=A0 Expansion ROM at 50020000 [disabled] [size=3D64K]=0A=
=A0=A0=A0 Capabilities: [40] Power Management version 3=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+=
=2CD1+=2CD2+=2CD3hot+=2CD3cold+)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-=0A=
=A0=A0=A0 Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+=0A=
=A0=A0=A0 =A0=A0=A0 Address: 00000000fee0300c=A0 Data: 41a1=0A=
=A0=A0=A0 Capabilities: [70] Express (v2) Endpoint=2C MSI 01=0A=
=A0=A0=A0 =A0=A0=A0 DevCap:=A0=A0=A0 MaxPayload 128 bytes=2C PhantFunc 0=2C=
 Latency L0s <128ns=2C L1 <2us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLRese=
t-=0A=
=A0=A0=A0 =A0=A0=A0 DevCtl:=A0=A0=A0 Report errors: Correctable- Non-Fatal-=
 Fatal- Unsupported-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-=
=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 MaxPayload 128 bytes=2C MaxReadReq 4096 bytes=
=0A=
=A0=A0=A0 =A0=A0=A0 DevSta:=A0=A0=A0 CorrErr+ UncorrErr- FatalErr- UnsuppRe=
q+ AuxPwr+ TransPend-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCap:=A0=A0=A0 Port #0=2C Speed 2.5GT/s=2C Width x1=
=2C ASPM L0s L1=2C Latency L0 <512ns=2C L1 <64us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ClockPM+ Surprise- LLActRep- BwNot-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCtl:=A0=A0=A0 ASPM Disabled=3B RCB 64 bytes Disabled=
- Retrain- CommClk+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt=
-=0A=
=A0=A0=A0 =A0=A0=A0 LnkSta:=A0=A0=A0 Speed 2.5GT/s=2C Width x1=2C TrErr- Tr=
ain- SlotClk+ DLActive- BWMgmt- ABWMgmt-=0A=
=A0=A0=A0 =A0=A0=A0 DevCap2: Completion Timeout: Not Supported=2C TimeoutDi=
s+=0A=
=A0=A0=A0 =A0=A0=A0 DevCtl2: Completion Timeout: 50us to 50ms=2C TimeoutDis=
-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCtl2: Target Link Speed: 2.5GT/s=2C EnterCompliance-=
 SpeedDis-=2C Selectable De-emphasis: -6dB=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0Transmit Margin: Normal Operating Range=2C=
 EnterModifiedCompliance- ComplianceSOS-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0Compliance De-emphasis: -6dB=0A=
=A0=A0=A0 =A0=A0=A0 LnkSta2: Current De-emphasis Level: -6dB=2C Equalizatio=
nComplete-=2C EqualizationPhase1-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0EqualizationPhase2-=2C EqualizationPhase3-=
=2C LinkEqualizationRequest-=0A=
=A0=A0=A0 Capabilities: [ac] MSI-X: Enable- Count=3D2 Masked-=0A=
=A0=A0=A0 =A0=A0=A0 Vector table: BAR=3D4 offset=3D00000000=0A=
=A0=A0=A0 =A0=A0=A0 PBA: BAR=3D4 offset=3D00000800=0A=
=A0=A0=A0 Capabilities: [cc] Vital Product Data=0A=
=A0=A0=A0 =A0=A0=A0 Unknown small resource type 00=2C will not decode more.=
=0A=
=A0=A0=A0 Capabilities: [100 v1] Advanced Error Reporting=0A=
=A0=A0=A0 =A0=A0=A0 UESta:=A0=A0=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt=
- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-=0A=
=A0=A0=A0 =A0=A0=A0 UEMsk:=A0=A0=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt=
- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-=0A=
=A0=A0=A0 =A0=A0=A0 UESvrt:=A0=A0=A0 DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbr=
t- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-=0A=
=A0=A0=A0 =A0=A0=A0 CESta:=A0=A0=A0 RxErr+ BadTLP- BadDLLP- Rollover- Timeo=
ut- NonFatalErr+=0A=
=A0=A0=A0 =A0=A0=A0 CEMsk:=A0=A0=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeo=
ut- NonFatalErr+=0A=
=A0=A0=A0 =A0=A0=A0 AERCap:=A0=A0=A0 First Error Pointer: 00=2C GenCap+ CGe=
nEn- ChkCap+ ChkEn-=0A=
=A0=A0=A0 Capabilities: [140 v1] Virtual Channel=0A=
=A0=A0=A0 =A0=A0=A0 Caps:=A0=A0=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D=
1=0A=
=A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128-=0A=
=A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 ArbSelect=3DFixed=0A=
=A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable+ ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D01=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-=
00=0A=
=A0=A0=A0 Kernel driver in use: r8169=0A=
=0A=
02:00.0 Network controller: Broadcom Corporation BCM43225 802.11b/g/n (rev =
01)=0A=
=A0=A0=A0 Subsystem: Hewlett-Packard Company Device 145e=0A=
=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-=0A=
=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <=
TAbort- <MAbort->SERR- <PERR- INTx-=0A=
=A0=A0=A0 Latency: 0=2C Cache Line Size: 64 bytes=0A=
=A0=A0=A0 Interrupt: pin A routed to IRQ 10=0A=
=A0=A0=A0 Region 0: Memory at 56000000 (64-bit=2C non-prefetchable) [size=
=3D16K]=0A=
=A0=A0=A0 Capabilities: [40] Power Management version 3=0A=
=A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-=2C=
D1-=2CD2-=2CD3hot-=2CD3cold-)=0A=
=A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D2 P=
ME-=0A=
=A0=A0=A0 Capabilities: [58] Vendor Specific Information: Len=3D78 <?>=0A=
=A0=A0=A0 Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+=0A=
=A0=A0=A0 =A0=A0=A0 Address: 0000000000000000=A0 Data: 0000=0A=
=A0=A0=A0 Capabilities: [d0] Express (v1) Endpoint=2C MSI 00=0A=
=A0=A0=A0 =A0=A0=A0 DevCap:=A0=A0=A0 MaxPayload 128 bytes=2C PhantFunc 0=2C=
 Latency L0s <4us=2C L1 unlimited=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLRese=
t-=0A=
=A0=A0=A0 =A0=A0=A0 DevCtl:=A0=A0=A0 Report errors: Correctable- Non-Fatal-=
 Fatal- Unsupported-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-=
=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 MaxPayload 128 bytes=2C MaxReadReq 128 bytes=
=0A=
=A0=A0=A0 =A0=A0=A0 DevSta:=A0=A0=A0 CorrErr+ UncorrErr- FatalErr- UnsuppRe=
q+ AuxPwr+ TransPend-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCap:=A0=A0=A0 Port #0=2C Speed 2.5GT/s=2C Width x1=
=2C ASPM L0s L1=2C Latency L0 <4us=2C L1 <64us=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ClockPM+ Surprise- LLActRep+ BwNot-=0A=
=A0=A0=A0 =A0=A0=A0 LnkCtl:=A0=A0=A0 ASPM L1 Enabled=3B RCB 64 bytes Disabl=
ed- Retrain- CommClk+=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt=
-=0A=
=A0=A0=A0 =A0=A0=A0 LnkSta:=A0=A0=A0 Speed 2.5GT/s=2C Width x1=2C TrErr- Tr=
ain- SlotClk+ DLActive+ BWMgmt- ABWMgmt-=0A=
=A0=A0=A0 Capabilities: [100 v1] Advanced Error Reporting=0A=
=A0=A0=A0 =A0=A0=A0 UESta:=A0=A0=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt=
- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-=0A=
=A0=A0=A0 =A0=A0=A0 UEMsk:=A0=A0=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt=
- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-=0A=
=A0=A0=A0 =A0=A0=A0 UESvrt:=A0=A0=A0 DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbr=
t- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-=0A=
=A0=A0=A0 =A0=A0=A0 CESta:=A0=A0=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeo=
ut- NonFatalErr+=0A=
=A0=A0=A0 =A0=A0=A0 CEMsk:=A0=A0=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeo=
ut- NonFatalErr+=0A=
=A0=A0=A0 =A0=A0=A0 AERCap:=A0=A0=A0 First Error Pointer: 14=2C GenCap+ CGe=
nEn- ChkCap+ ChkEn-=0A=
=A0=A0=A0 Capabilities: [13c v1] Virtual Channel=0A=
=A0=A0=A0 =A0=A0=A0 Caps:=A0=A0=A0 LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D=
1=0A=
=A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128-=0A=
=A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 ArbSelect=3DFixed=0A=
=A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 InProgress-=0A=
=A0=A0=A0 =A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=A0 PATOffset=3D00 MaxTimeSlot=
s=3D1 RejSnoopTrans-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128- TW=
RR128- WRR256-=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Ctrl:=A0=A0=A0 Enable+ ID=3D0 ArbSelect=3DFix=
ed TC/VC=3D01=0A=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Status:=A0=A0=A0 NegoPending- InProgress-=0A=
=A0=A0=A0 Capabilities: [160 v1] Device Serial Number 00-00-fe-ff-ff-00-c4-=
17=0A=
=A0=A0=A0 Capabilities: [16c v1] Power Budgeting <?>=0A=
=0A=
=0A=
=0A=
 =0A=
=0A=
 [7.6.] SCSI information (from /proc/scsi/scsi) =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ cat /proc/scsi/scsi=0A=
Attached devices:=0A=
Host: scsi0 Channel: 00 Id: 00 Lun: 00=0A=
=A0 Vendor: ATA=A0=A0=A0=A0=A0 Model: ST9250410AS=A0=A0=A0=A0=A0 Rev: 0006=
=0A=
=A0 Type:=A0=A0 Direct-Access=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 ANSI=A0 SCSI revision: 05=0A=
=0A=
 =0A=
=0A=
 [7.7.] Other information that might be relevant to the problem (please =0A=
look in /proc and include all information that you think to be =0A=
relevant): =0A=
=0A=
 annalisa@annalisa-HP-Mini-210-1000:~$ ls /proc=0A=
1=A0=A0=A0=A0 1587=A0 1721=A0 1889=A0 219=A0=A0 36=A0=A0 885=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 fb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sched_debug=0A=
10=A0=A0=A0 1591=A0 1726=A0 1890=A0 22=A0=A0=A0 37=A0=A0 891=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 filesystems=A0=A0=A0 schedstat=0A=
1016=A0 1594=A0 1737=A0 1891=A0 220=A0=A0 4=A0=A0=A0 9=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 fs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scsi=0A=
11=A0=A0=A0 16=A0=A0=A0 1741=A0 1893=A0 2210=A0 469=A0 926=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 interrupts=A0=A0=A0=A0 self=0A=
1121=A0 1602=A0 1742=A0 1895=A0 224=A0=A0 49=A0=A0 933=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 iomem=A0=A0=A0=A0=A0=A0=A0=A0=A0 slabinfo=0A=
1133=A0 1614=A0 1750=A0 19=A0=A0=A0 227=A0=A0 5=A0=A0=A0 950=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 ioports=A0=A0=A0=A0=A0=A0=A0 softirqs=0A=
114=A0=A0 1622=A0 1752=A0 1961=A0 23=A0=A0=A0 52=A0=A0 953=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 irq=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stat=0A=
1141=A0 1626=A0 1769=A0 1966=A0 245=A0=A0 568=A0 957=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 kallsyms=A0=A0=A0=A0=A0=A0 swaps=0A=
1155=A0 1640=A0 1770=A0 1968=A0 246=A0=A0 575=A0 985=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 kcore=A0=A0=A0=A0=A0=A0=A0=A0=A0 sys=0A=
1161=A0 1642=A0 1773=A0 1971=A0 25=A0=A0=A0 580=A0 989=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 key-users=A0=A0=A0=A0=A0 sysrq-trigger=0A=
12=A0=A0=A0 1647=A0 1774=A0 2=A0=A0=A0=A0 2568=A0 581=A0 991=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 kmsg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysvipc=0A=
1276=A0 1652=A0 1776=A0 20=A0=A0=A0 26=A0=A0=A0 598=A0 acpi=A0=A0=A0=A0=A0=
=A0=A0=A0 kpagecount=A0=A0=A0=A0 timer_list=0A=
13=A0=A0=A0 1653=A0 1778=A0 2000=A0 2612=A0 603=A0 asound=A0=A0=A0=A0=A0=A0=
 kpageflags=A0=A0=A0=A0 timer_stats=0A=
14=A0=A0=A0 1654=A0 1781=A0 2001=A0 27=A0=A0=A0 616=A0 buddyinfo=A0=A0=A0 l=
atency_stats=A0 tty=0A=
1403=A0 1655=A0 1782=A0 2034=A0 28=A0=A0=A0 621=A0 bus=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 loadavg=A0=A0=A0=A0=A0=A0=A0 uptime=0A=
1408=A0 1669=A0 18=A0=A0=A0 2035=A0 3=A0=A0=A0=A0 625=A0 cgroups=A0=A0=A0=
=A0=A0 locks=A0=A0=A0=A0=A0=A0=A0=A0=A0 version=0A=
1449=A0 1674=A0 1815=A0 2042=A0 30=A0=A0=A0 7=A0=A0=A0 cmdline=A0=A0=A0=A0=
=A0 mdstat=A0=A0=A0=A0=A0=A0=A0=A0 vmallocinfo=0A=
15=A0=A0=A0 1686=A0 1832=A0 2043=A0 31=A0=A0=A0 71=A0=A0 consoles=A0=A0=A0=
=A0 meminfo=A0=A0=A0=A0=A0=A0=A0 vmstat=0A=
1512=A0 1689=A0 1839=A0 2093=A0 32=A0=A0=A0 72=A0=A0 cpuinfo=A0=A0=A0=A0=A0=
 misc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zoneinfo=0A=
1522=A0 1693=A0 1848=A0 21=A0=A0=A0 33=A0=A0=A0 744=A0 crypto=A0=A0=A0=A0=
=A0=A0 modules=0A=
1571=A0 1697=A0 1855=A0 2101=A0 331=A0=A0 774=A0 devices=A0=A0=A0=A0=A0 mou=
nts=0A=
1572=A0 17=A0=A0=A0 1862=A0 2102=A0 34=A0=A0=A0 8=A0=A0=A0 diskstats=A0=A0=
=A0 mtrr=0A=
1573=A0 1704=A0 1871=A0 217=A0=A0 342=A0=A0 801=A0 dma=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 net=0A=
1576=A0 1709=A0 1877=A0 2171=A0 344=A0=A0 820=A0 driver=A0=A0=A0=A0=A0=A0 p=
agetypeinfo=0A=
1577=A0 1716=A0 1888=A0 218=A0=A0 35=A0=A0=A0 847=A0 execdomains=A0 partiti=
ons=0A=
=0A=
=0A=
i have this problem from 10.04 to 13.10 & with all kernels until lastest ve=
rsion of mainline kernel 3.12.rc3.=0A=
i have already post a report inside the Ubuntu launchpad (_https://bugs.lau=
nchpad.net/ubuntu/+source/linux/+bug/1188965) and don't solve the problem=
=2C Christopher M.Penalver (penalvch)=A0 say to me contact you.=0A=
=0A=
the correct model of this pc is: HP MINI 210-1010sl=0A=
=0A=
------>installation log:=0A=
=0A=
annalisa@annalisa-HP-Mini-210-1000:~/Scaricati$ sudo dpkg -i *.debSeleziona=
to il pacchetto linux-headers-3.12.0-031200rc3 non precedentemente selezion=
ato.=0A=
(Lettura del database... 349315 file e directory attualmente installati.)=
=0A=
Estrazione di linux-headers-3.12.0-031200rc3 (da linux-headers-3.12.0-03120=
0rc3_3.12.0-031200rc3.201309291835_all.deb)...=0A=
Selezionato il pacchetto linux-headers-3.12.0-031200rc3-generic non precede=
ntemente selezionato.=0A=
Estrazione di linux-headers-3.12.0-031200rc3-generic (da linux-headers-3.12=
.0-031200rc3-generic_3.12.0-031200rc3.201309291835_i386.deb)...=0A=
Selezionato il pacchetto linux-image-3.12.0-031200rc3-generic non precedent=
emente selezionato.=0A=
Estrazione di linux-image-3.12.0-031200rc3-generic (da linux-image-3.12.0-0=
31200rc3-generic_3.12.0-031200rc3.201309291835_i386.deb)...=0A=
Done.=0A=
Configurazione di linux-headers-3.12.0-031200rc3 (3.12.0-031200rc3.20130929=
1835)...=0A=
Configurazione di linux-headers-3.12.0-031200rc3-generic (3.12.0-031200rc3.=
201309291835)...=0A=
Examining /etc/kernel/header_postinst.d.=0A=
run-parts: executing /etc/kernel/header_postinst.d/dkms 3.12.0-031200rc3-ge=
neric /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
Error! Bad return status for module build on kernel: 3.12.0-031200rc3-gener=
ic (i686)=0A=
Consult /var/lib/dkms/bcmwl/6.20.155.1+bdcom/build/make.log for more inform=
ation.=0A=
Configurazione di linux-image-3.12.0-031200rc3-generic (3.12.0-031200rc3.20=
1309291835)...=0A=
Running depmod.=0A=
update-initramfs: deferring update (hook will be called later)=0A=
Examining /etc/kernel/postinst.d.=0A=
run-parts: executing /etc/kernel/postinst.d/apt-auto-removal 3.12.0-031200r=
c3-generic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
run-parts: executing /etc/kernel/postinst.d/dkms 3.12.0-031200rc3-generic /=
boot/vmlinuz-3.12.0-031200rc3-generic=0A=
Error! Bad return status for module build on kernel: 3.12.0-031200rc3-gener=
ic (i686)=0A=
Consult /var/lib/dkms/bcmwl/6.20.155.1+bdcom/build/make.log for more inform=
ation.=0A=
run-parts: executing /etc/kernel/postinst.d/initramfs-tools 3.12.0-031200rc=
3-generic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
update-initramfs: Generating /boot/initrd.img-3.12.0-031200rc3-generic=0A=
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8168g-3.fw for module=
 r8169=0A=
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8106e-2.fw for module=
 r8169=0A=
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8411-2.fw for module =
r8169=0A=
run-parts: executing /etc/kernel/postinst.d/pm-utils 3.12.0-031200rc3-gener=
ic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
run-parts: executing /etc/kernel/postinst.d/update-notifier 3.12.0-031200rc=
3-generic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
run-parts: executing /etc/kernel/postinst.d/zz-update-grub 3.12.0-031200rc3=
-generic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
Creazione di grub.cfg...=0A=
Trovata immagine linux: /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.12.0-031200rc3-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-31-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-31-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-30-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-30-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-29-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-29-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-27-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-27-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-26-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-26-generic=0A=
Found memtest86+ image: /boot/memtest86+.bin=0A=
Trovato Windows 7 (loader) su /dev/sda1=0A=
fatto=0A=
annalisa@annalisa-HP-Mini-210-1000:~/Scaricati$ =0A=
=0A=
=0A=
------>removing the kernel:=0A=
=0A=
annalisa@annalisa-HP-Mini-210-1000:~$ sudo apt-get purge linux-image-3.12.0=
-031200rc3-generic =0A=
Lettura elenco dei pacchetti... Fatto=0A=
Generazione albero delle dipendenze=A0=A0=A0=A0=A0=A0 =0A=
Lettura informazioni sullo stato... Fatto=0A=
I seguenti pacchetti saranno RIMOSSI:=0A=
=A0 linux-image-3.12.0-031200rc3-generic*=0A=
0 aggiornati=2C 0 installati=2C 1 da rimuovere e 2 non aggiornati.=0A=
Dopo quest'operazione=2C verranno liberati 134 MB di spazio su disco.=0A=
Continuare [S/n]? s=0A=
(Lettura del database... 378919 file e directory attualmente installati.)=
=0A=
Rimozione di linux-image-3.12.0-031200rc3-generic...=0A=
WARN: Proceeding with removing running kernel image.=0A=
Examining /etc/kernel/prerm.d.=0A=
run-parts: executing /etc/kernel/prerm.d/dkms 3.12.0-031200rc3-generic /boo=
t/vmlinuz-3.12.0-031200rc3-generic=0A=
Examining /etc/kernel/postrm.d .=0A=
run-parts: executing /etc/kernel/postrm.d/initramfs-tools 3.12.0-031200rc3-=
generic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
update-initramfs: Deleting /boot/initrd.img-3.12.0-031200rc3-generic=0A=
run-parts: executing /etc/kernel/postrm.d/zz-update-grub 3.12.0-031200rc3-g=
eneric /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
Creazione di grub.cfg...=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-31-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-31-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-30-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-30-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-29-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-29-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-27-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-27-generic=0A=
Trovata immagine linux: /boot/vmlinuz-3.8.0-26-generic=0A=
Trovata immagine initrd: /boot/initrd.img-3.8.0-26-generic=0A=
Found memtest86+ image: /boot/memtest86+.bin=0A=
Trovato Windows 7 (loader) su /dev/sda1=0A=
fatto=0A=
The link /vmlinuz is a damaged link=0A=
Removing symbolic link vmlinuz =0A=
=A0you may need to re-run your boot loader[grub]=0A=
The link /initrd.img is a damaged link=0A=
Removing symbolic link initrd.img =0A=
=A0you may need to re-run your boot loader[grub]=0A=
Eliminazione dei file di configurazione di linux-image-3.12.0-031200rc3-gen=
eric...=0A=
Examining /etc/kernel/postrm.d .=0A=
run-parts: executing /etc/kernel/postrm.d/initramfs-tools 3.12.0-031200rc3-=
generic /boot/vmlinuz-3.12.0-031200rc3-generic=0A=
run-parts: executing /etc/kernel/postrm.d/zz-update-grub 3.12.0-031200rc3-g=
eneric /boot/vmlinuz-3.12.0-031200rc3-generic 		 	   		  =

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
