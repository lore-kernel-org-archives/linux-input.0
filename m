Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026B36B05D
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776789; cv=pass; b=GINLxrnNpZt9JWz0JsQgHw+4Wu0MRxJNIiHX4RKt6VLH8GS5X5mKGcJ6csdNjWYjJPHNrxQTVh5JAQ2z2eYgnUxMkVPLlhaRWDiuswNIe7Ir7g4hR5DRaeFJu7l2MgwNox8MVYYD48/fjckkefaA+eEvf7PUYqgqdYqA31176sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776789; c=relaxed/simple;
	bh=yBWDIiBMJJJFVU6BjVmUMi3lC8d8ZJX891w5EEss+rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u52Zz+8TKhd7cBhcWIuP53FwAS6yQxm8Ns7wKsHK5xtjYULnxHVu7vWd5mn9ftULpWGwgqrcCROvfRcuDQqwu3ihgGL4x4cLRRrfmBopI+FJpvYECISGzRcp83FCbfLGBs3+eRf9bgpmLVArt+kuUL1EkJLK3FVngpDgPCitVoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQM/ck3w; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQM/ck3w"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a0d53f3d1so40627426d6.3
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 21:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776787; cv=none;
        d=google.com; s=arc-20240605;
        b=JtC7k1QwNhS57a6cT64c1Kh76kQDiqjFGKIgJYWxQOesYl5ytlZi4gqoWFwfDYYzbK
         HbB8tEYPKzBE72KxFYxu/lPBKPPYUJ3c5EaQ3FgivprN5//X7iTIB9MN4PiwFr/FYWf/
         klqwhmTOCP8e/KU1F01y3XkJ7EeKpYSqptt2OM4GPcfjqg4UFN8vqfuO2NqfiJvo2UqN
         R6fDHo/Q3DAkZMe5c+pjZmzPVZ6PUO277e5mdXqFrMHh2djf/qe8Uj3Yy0C2YTNhpltb
         TVJA19UcM3xnWZ88rXDQtyU9K2++M8xjLfY9fpXV0+c4lUKOta8pM84W58UGtTL2FQTT
         3oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xE9TFSh8B05swav2IDOwz6UfAoQWMYluBp12x3FMS2k=;
        fh=6z7wtw+/RkdOVJjyIDAwjrtHsOgCx0j1vgE4vC8LHVM=;
        b=jNZlVJedtNtC3yNDLvmgB03VCZWM93hQKFrJvNXliQ4/we+iULYBzX9QQmidiCvFlc
         I67cSGKh0t16cU8qVggfSAOzIMqiNlYES7QoAvZLx3Glt9XTlJQca00GXyJbzWqPzZg3
         QdyJmUOuuhGF+b9jKyItQzX7I5+9Hdxy1V9xkBElqTPla/FTXWBSw1ll9igxTU7naAnT
         zrbTJiZ5Gtc/2eM6HjjYqdp5S9bRzA1kHln4ZjxaQrxPzhGSDA2pXCBrBBPYAhMGBzKa
         t8vvWZyaKV9csGVvj+wOEn0Sf6kjBHgVj6o8oU1M1sKYq7jZRPpvSA8Jhyz+KZDrZ9fp
         INPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772776787; x=1773381587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE9TFSh8B05swav2IDOwz6UfAoQWMYluBp12x3FMS2k=;
        b=RQM/ck3wlXf0DWTjrERvBd4+SBHIBm/Q/gu/dIhAhvSWpIPA23ISNcypA1IwbDJJIU
         D00jYBjWFoKMtrywYnQsx5JKM1f7ZIEVM7qLE9Di39jsDZmJpaRgUdeOrR6R+pvZ85BY
         bTKkaMxcRoracwED978ia9mn+pldteKji8bIPDq1KAeHSnG9uY5IqMuxQRsL+XTyewCg
         UBfwboHlYZO04rhzvzGwhj9OBREAvOCNmpMgj2RBlOzy5p6Ep26KoYzgeM4GWDmHf1Mc
         bnDAS51Y8P4Dx0h9CWP9XtzqGQVuu2U86mopiuP2o+zwUZs9ZgJDrkDcXVvB9k+D+Gdw
         PxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776787; x=1773381587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xE9TFSh8B05swav2IDOwz6UfAoQWMYluBp12x3FMS2k=;
        b=vm4EWjlPuoG/+R5WdwMQQ7I19fNMQCZReXTYoDBrDKRFnaoQfQU00qqpAD0y4oOBMZ
         ott7pBR+ZQQeepLlj6/7l0DD+HwxKNFyR1CCFH76o5xlmM1dzYvtXm//c+IgpCh5mD2Q
         FkN8DvUKwMsepNxoyZyinFyISqauM6ZBtBlt/87WhkCuKZELypj4tOoV2ZmiG42xz8Yd
         FPWxBKBuxg2pdYoehQIEUkd6tKiRpHL0vuOT5rKlpkADaYEkgJ23+zA6wBC6uzi1fVFU
         8KGxdSAycx53SYoYa1jnC8ZSiydbT4gnXoggnwjxIYFYGIoS6RGsjKDKLFaXRWH2ewck
         vTmg==
X-Forwarded-Encrypted: i=1; AJvYcCXCfD5C5QKpMM+DYCJtah4/YMQbcFtigJb0eRN953r2aV8R2JcYe/5ow0IgkuR+dVct44PeCNVh7E3FYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZ1R5nZsOgBhxqMKVWQp7Z7qCyNo1sNhOBgoM3JFmc33S5fw1
	8cWxTqiqQMdcCD5W/NywvGd1CpBXNoW59vMxU4jqQksnHUDB8X7xFoGsF2lxweM4FtGbEmJGOsP
	WGg7obrOI89aBxSg5vod9Q2E/us4ZwCU=
X-Gm-Gg: ATEYQzyNG+4/UF/7icd9frcga0WROZHNuKR1mMPpF/xYxB39qn3c9MtpxcYsRaEKWdm
	YOi7U9TrvZIK9G70L13IxNxSwgliss46mzYtHQkYeDGsQNKVSUpLwZxb/QiSEj/3BlLCYhZ5vvD
	VWB+0Qtza/LrK6tIYyOrZJg6g5kk5BXEW0zN+5Do3kI4NCYKlepOSL0AH/q1CYA6cJ4vWN7bnmT
	xLehO+gOaDUOzabuvVtrC9GKL6fr+dMm4sgjMuHfhKfkM3d4qp79526oG+eZ14vO0xvjz7RdRqN
	00ZhBkM=
X-Received: by 2002:a05:6214:202b:b0:899:ad51:fb64 with SMTP id
 6a1803df08f44-89a30ad193emr11307776d6.41.1772776786959; Thu, 05 Mar 2026
 21:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228033936.285945-1-nichen@iscas.ac.cn>
In-Reply-To: <20260228033936.285945-1-nichen@iscas.ac.cn>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 5 Mar 2026 21:59:31 -0800
X-Gm-Features: AaiRm53tZVUQsF-VzXmgYwj0rdS8VjEhKaEaNHCWcQ40FUDizQOnJYLWNIBe998
Message-ID: <CAFqHKTk4enmu9iq9EbyQaLw7dbUZXs8Sw8-F_Cxx9WevJSGPNQ@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-lenovo-go: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: mpearson-lenovo@squebb.ca, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 7:41=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove unnecessary semicolons after switch statements and function
> bodies. Most issues were reported by Coccinelle/coccicheck using the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci. Additional
> instances found during manual code review were also fixed.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/hid/hid-lenovo-go.c | 52 ++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 6972d13802e2..77e3823447e5 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -455,7 +455,7 @@ static int hid_go_feature_status_event(struct command=
_report *cmd_rep)
>                         return 0;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>         case FEATURE_IMU_BYPASS:
>                 switch (cmd_rep->device_type) {
>                 case LEFT_CONTROLLER:
> @@ -466,7 +466,7 @@ static int hid_go_feature_status_event(struct command=
_report *cmd_rep)
>                         return 0;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>                 break;
>         case FEATURE_LIGHT_ENABLE:
>                 drvdata.rgb_en =3D cmd_rep->data[0];
> @@ -481,7 +481,7 @@ static int hid_go_feature_status_event(struct command=
_report *cmd_rep)
>                         return 0;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>                 break;
>         case FEATURE_TOUCHPAD_ENABLE:
>                 drvdata.tp_en =3D cmd_rep->data[0];
> @@ -515,7 +515,7 @@ static int hid_go_motor_event(struct command_report *=
cmd_rep)
>                         return 0;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>                 break;
>         case RUMBLE_MODE:
>                 switch (cmd_rep->device_type) {
> @@ -527,7 +527,7 @@ static int hid_go_motor_event(struct command_report *=
cmd_rep)
>                         return 0;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>         case TP_VIBRATION_ENABLE:
>                 drvdata.tp_vibration_en =3D cmd_rep->data[0];
>                 return 0;
> @@ -625,7 +625,7 @@ static int hid_go_os_mode_cfg_event(struct command_re=
port *cmd_rep)
>                 return 0;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>  }
>
>  static int hid_go_set_event_return(struct command_report *cmd_rep)
> @@ -699,14 +699,14 @@ static int hid_go_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>                 default:
>                         ret =3D -EINVAL;
>                         break;
> -               };
> +               }
>                 break;
>         case OS_MODE_DATA:
>                 ret =3D hid_go_os_mode_cfg_event(cmd_rep);
>                 break;
>         default:
>                 goto passthrough;
> -       };
> +       }
>         dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
>                 GO_PACKET_SIZE, data);
>
> @@ -925,7 +925,7 @@ static ssize_t feature_status_store(struct device *de=
v,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         if (ret < 0)
>                 return ret;
> @@ -1013,7 +1013,7 @@ static ssize_t feature_status_show(struct device *d=
ev,
>                         break;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>                 count =3D sysfs_emit(buf, "%u\n", i);
>                 break;
>         case FEATURE_FPS_SWITCH_STATUS:
> @@ -1032,7 +1032,7 @@ static ssize_t feature_status_show(struct device *d=
ev,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         return count;
>  }
> @@ -1070,7 +1070,7 @@ static ssize_t feature_status_options(struct device=
 *dev,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         if (count)
>                 buf[count - 1] =3D '\n';
> @@ -1111,7 +1111,7 @@ static ssize_t motor_config_store(struct device *de=
v,
>                 ret =3D sysfs_match_string(intensity_text, buf);
>                 val =3D ret;
>                 break;
> -       };
> +       }
>
>         if (ret < 0)
>                 return ret;
> @@ -1161,7 +1161,7 @@ static ssize_t motor_config_show(struct device *dev=
,
>                         break;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>                 if (i >=3D ARRAY_SIZE(enabled_status_text))
>                         return -EINVAL;
>
> @@ -1177,7 +1177,7 @@ static ssize_t motor_config_show(struct device *dev=
,
>                         break;
>                 default:
>                         return -EINVAL;
> -               };
> +               }
>                 if (i >=3D ARRAY_SIZE(rumble_mode_text))
>                         return -EINVAL;
>
> @@ -1197,7 +1197,7 @@ static ssize_t motor_config_show(struct device *dev=
,
>
>                 count =3D sysfs_emit(buf, "%s\n", intensity_text[i]);
>                 break;
> -       };
> +       }
>
>         return count;
>  }
> @@ -1232,7 +1232,7 @@ static ssize_t motor_config_options(struct device *=
dev,
>                                                enabled_status_text[i]);
>                 }
>                 break;
> -       };
> +       }
>
>         if (count)
>                 buf[count - 1] =3D '\n';
> @@ -1333,7 +1333,7 @@ static ssize_t device_status_show(struct device *de=
v,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         if (i >=3D ARRAY_SIZE(cal_status_text))
>                 return -EINVAL;
> @@ -1459,7 +1459,7 @@ static int rgb_attr_show(void)
>         index =3D drvdata.rgb_profile + 3;
>
>         return rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, index, 0, 0);
> -};
> +}
>
>  static ssize_t rgb_effect_store(struct device *dev,
>                                 struct device_attribute *attr, const char=
 *buf,
> @@ -1489,7 +1489,7 @@ static ssize_t rgb_effect_store(struct device *dev,
>
>         drvdata.rgb_effect =3D effect;
>         return count;
> -};
> +}
>
>  static ssize_t rgb_effect_show(struct device *dev,
>                                struct device_attribute *attr, char *buf)
> @@ -1552,7 +1552,7 @@ static ssize_t rgb_speed_store(struct device *dev,
>         drvdata.rgb_speed =3D val;
>
>         return count;
> -};
> +}
>
>  static ssize_t rgb_speed_show(struct device *dev, struct device_attribut=
e *attr,
>                               char *buf)
> @@ -1594,7 +1594,7 @@ static ssize_t rgb_mode_store(struct device *dev, s=
truct device_attribute *attr,
>         drvdata.rgb_mode =3D val;
>
>         return count;
> -};
> +}
>
>  static ssize_t rgb_mode_show(struct device *dev, struct device_attribute=
 *attr,
>                              char *buf)
> @@ -1609,7 +1609,7 @@ static ssize_t rgb_mode_show(struct device *dev, st=
ruct device_attribute *attr,
>                 return -EINVAL;
>
>         return sysfs_emit(buf, "%s\n", rgb_mode_text[drvdata.rgb_mode]);
> -};
> +}
>
>  static ssize_t rgb_mode_index_show(struct device *dev,
>                                    struct device_attribute *attr, char *b=
uf)
> @@ -1649,7 +1649,7 @@ static ssize_t rgb_profile_store(struct device *dev=
,
>         drvdata.rgb_profile =3D val;
>
>         return count;
> -};
> +}
>
>  static ssize_t rgb_profile_show(struct device *dev,
>                                 struct device_attribute *attr, char *buf)
> @@ -1665,7 +1665,7 @@ static ssize_t rgb_profile_show(struct device *dev,
>                 return -EINVAL;
>
>         return sysfs_emit(buf, "%hhu\n", drvdata.rgb_profile);
> -};
> +}
>
>  static ssize_t rgb_profile_range_show(struct device *dev,
>                                       struct device_attribute *attr, char=
 *buf)
> @@ -1704,7 +1704,7 @@ static void hid_go_brightness_set(struct led_classd=
ev *led_cdev,
>                 break;
>         default:
>                 dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n=
", ret);
> -       };
> +       }
>  }
>
>  #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)   =
      \
> --
> 2.25.1
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
